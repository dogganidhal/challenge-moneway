# challenge-moneway

Application iOS en Swift qui récupére une liste de dépôts depuis [l'API de GitHub](https://api.github.com)

L'application est composée de 2 parties :

Une vue avec un champ de recherche et un UITableView pour afficher les dépôts récupérés depuis l'API de GitHub,
Une vue avec un second UITableView pour afficher les branches et les contributeurs avec leur image de profil. 

---

### Réalisation

* Implémentation avec le design pattern MVVM (Model View ViewModel)
* Couche network avec [Moya](https://github.com/Moya/Moya)
* L'application supporte le mode offline (il faut au moins avoir fait des recherches pour avoir un minimum dans le cache)
* La mise en cache est assurée avec une base de données locale, gérée par [Realm](https://realm.io)
* L'application utilise les pricinpes du Reactive Programming via la bibliothèque [RxSwift et RxCocoa](https://github.com/ReactiveX/RxSwift)

---

### Utilisation avec Xcode

* Cloner le dépôt :
```
git clone https://github.com/dogganidhal/challenge-moneway && cd ChallengeMoneway
```
  
* Installer les pods :
```
pod install
```
  
* Ouvir dans Xcode :
```
open -a Xcode ChallengeMoneway.xcworkspace
```
  
