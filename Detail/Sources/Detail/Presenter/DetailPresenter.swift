import SwiftUI
import Combine
import Core
import Games
import Detail

public class DetailPresenter<DetailUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject where DetailUseCase.Request == Int, DetailUseCase.Response == GameDomainModel, FavoriteUseCase.Request == Int, FavoriteUseCase.Response == GameDomainModel {

  private var cancellables: Set<AnyCancellable> = []
  private let _detailUseCase: DetailUseCase
  private let _favoriteUseCase: FavoriteUseCase

  @Published public var detail: GameDomainModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false

  public init(detailUseCase: DetailUseCase, favoriteUseCase: FavoriteUseCase) {
    _detailUseCase = detailUseCase
    _favoriteUseCase = favoriteUseCase
  }

  public func getDetail(request: DetailUseCase.Request) {
    isLoading = true
    _detailUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { detail in
        self.detail = detail
      })
      .store(in: &cancellables)
  }

  public func updateFavorite(request: FavoriteUseCase.Request) {
    isLoading = true
    _favoriteUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { detail in
        self.detail = detail
      })
      .store(in: &cancellables)
  }
}
