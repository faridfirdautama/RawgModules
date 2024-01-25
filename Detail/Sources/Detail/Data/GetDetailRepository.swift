import Core
import Combine
import Games

public struct GetDetailRepository<
  DetailLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where
DetailLocaleDataSource.Request == Any,
DetailLocaleDataSource.Response == GameModuleEntity,
RemoteDataSource.Request == Int,
RemoteDataSource.Response == GameDetailResponse,
Transformer.Request == Int,
Transformer.Response == GameDetailResponse,
Transformer.Entity == GameModuleEntity,
Transformer.Domain == GameDomainModel
{

  public typealias Request = Int
  public typealias Response = GameDomainModel

  private let _localeDataSource: DetailLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: DetailLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }

  public func execute(request: Int?) -> AnyPublisher<GameDomainModel, Error> {
    guard let request = request else { fatalError() }
    return _localeDataSource.get(id: request)
      .flatMap { result -> AnyPublisher<GameDomainModel, Error> in
        if result.descriptions == "" {
          return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .catch { _ in _localeDataSource.get(id: request) }
            .flatMap { _localeDataSource.update(id: request, entity: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.get(id: request)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }.eraseToAnyPublisher()
        } else {
          return _localeDataSource.get(id: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
}

