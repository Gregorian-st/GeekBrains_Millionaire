//
//  GameViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func gameFinished(with earned: Int)
    func nextQuestion() -> Bool
}

class GameViewController: UIViewController {
    
    var gameQuestions: [Question] = []
    let game = Game.instance
    weak var gameDelegate: GameViewDelegate!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var lastSumLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet var answerLabels: [UILabel]!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBAction func buttonFinishDidTapped(_ sender: UIButton) {
        let earned = game.session.earnToTake
        gameDelegate.gameFinished(with: earned)
        showMessageAndExit(message: "Поздравляем!\nВы заработали \(earned)₽")
    }
    
    @IBAction func buttonAnswerDidTapped(_ sender: UIButton) {
        checkAnswer(tag: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameData()
        updateView()
    }
    
    func updateView() {
        let qNum = game.session.currentQuestion - 1
        questionLabel.text = "Вопрос №\(game.session.currentQuestion)"
        lastSumLabel.text = "Можно забрать \(game.session.earnToTake)₽"
        questionTextView.text = gameQuestions[qNum].questionText
        answerLabels.forEach {
            $0.isHidden = false
        }
        answerButtons.forEach {
            $0.isHidden = false
            $0.setTitle(gameQuestions[qNum].answerSet[$0.tag] , for: .normal)
        }
        finishButton.isHidden = qNum == 0
    }
    
    func checkAnswer(tag: Int) {
        let qNum = game.session.currentQuestion - 1
        if gameQuestions[qNum].rightAnswer.rawValue == tag {
            if gameDelegate.nextQuestion() {
                updateView()
            } else {
                let earned = game.session.earnedMin
                gameDelegate.gameFinished(with: earned)
                showMessageAndExit(message: "Поздравляем! Вы выиграли!\nВы заработали \(earned)₽")
            }
        } else {
            let earned = game.session.earnedMin
            gameDelegate.gameFinished(with: earned)
            showMessageAndExit(message: "Ответ неверный!\nВы заработали \(earned)₽")
        }
    }
    
    func showMessageAndExit(message: String) {
        let alertController = UIAlertController(title: "Кто хочет стать миллионером",
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
            self.performSegue(withIdentifier: "unwindFromGame", sender: self)
        } ))
        present(alertController, animated: true, completion: nil)
    }
    
    private func setGameData() {
        var questionData = Array<Array<Question>>()
        
        let questionSet1 = [Question(questionText: "Что, согласно русской пословице, в мешке не утаишь?",
                                     answerSet: ["Мыло", "Шило", "Деньги", "Дырку"],
                                     rightAnswer: .b),
                            Question(questionText: "В каких единицах измеряют силу электрического тока?",
                                     answerSet: ["Вольт", "Фарад", "Ампер", "Ом"],
                                     rightAnswer: .c),
                            Question(questionText: "Как называется известный мультфильм Норштейна?",
                                     answerSet: ["Ну, погоди!", "Простоквашино", "Смешарики", "Ёжик в тумане"],
                                     rightAnswer: .d),
                            Question(questionText: "Какую фамилию носил главный герой поэмы А. Твардовского?",
                                     answerSet: ["Иванов", "Петров", "Тёркин", "Шукшин"],
                                     rightAnswer: .c),
                            Question(questionText: "На каком языке сделана надпись 'Бог и моё право' на гербе Великобритании?",
                                     answerSet: ["На французском", "На английском", "На латыни", "На итальянском"],
                                     rightAnswer: .a),
                            Question(questionText: "Как называется боязнь глубины?",
                                     answerSet: ["Таласофобия", "Кимофобия", "Гидрофобия", "Батофобия"],
                                     rightAnswer: .d),
                            Question(questionText: "Какой стране принадлежит самый большой остров Земли Гренландия?",
                                     answerSet: ["Исландия", "Бельгия", "Дания", "Ирландия"],
                                     rightAnswer: .c),
                            Question(questionText: "В какой стране появилась мандолина?",
                                     answerSet: ["Италия", "Испания", "Венгрия", "Греция"],
                                     rightAnswer: .a),
                            Question(questionText: "В какой из этих городов Новый год приходит раньше?",
                                     answerSet: ["Пермь", "Красноярск", "Омск", "Новосибирск"],
                                     rightAnswer: .b),
                            Question(questionText: "Что держит в руках женщина на картине Кустодиева 'Русская Венера'?",
                                     answerSet: ["Весло", "Веник", "Венок", "Чашу"],
                                     rightAnswer: .b),
                            Question(questionText: "Несколько раз Донецк менял свое название. Какое имя город носил с 1924 по 1961 год?",
                                     answerSet: ["Свердлово", "Ленино", "Дзержинск", "Сталино"],
                                     rightAnswer: .d),
                            Question(questionText: "Какой народ придумал танец чардаш?",
                                     answerSet: ["Венгры", "Чехи", "Молдаване", "Болгары"],
                                     rightAnswer: .a),
                            Question(questionText: "С чем часто охотятся на рыбу протоптера между сезонами дождей?",
                                     answerSet: ["С сетями", "С сачками", "С лопатами", "С ружьями"],
                                     rightAnswer: .c),
                            Question(questionText: "Каким видом спорта серьёзно увлекался французский лётчик Ролан Гаррос?",
                                     answerSet: ["Поло", "Регби", "Гольф", "Пинг-понг"],
                                     rightAnswer: .b),
                            Question(questionText: "Что такое лобогрейка?",
                                     answerSet: ["Печка", "Шапка", "Болезнь", "Жнейка"],
                                     rightAnswer: .d)
        ]
        questionData.append(questionSet1)
        
        let questionSet2 = [Question(questionText: "За чем послала жена мужа в мультфильме 'Падал прошлогодний снег'?",
                                     answerSet: ["За хлебом", "За пивом", "За ёлкой", "За солью"],
                                     rightAnswer: .c),
                            Question(questionText: "Что доставал из широких штанин лирический герой Маяковского?",
                                     answerSet: ["Паспорт", "Наган", "Платок", "Кошелёк"],
                                     rightAnswer: .a),
                            Question(questionText: "Из чего, согласно поговорке не выкинешь слов?",
                                     answerSet: ["Песни", "Газет", "Молитвы", "Конституции"],
                                     rightAnswer: .a),
                            Question(questionText: "Какое из искусств В. И. Ленин считал важнейшим для Советской России?",
                                     answerSet: ["Цирк", "Кино", "Балет", "Оперу"],
                                     rightAnswer: .b),
                            Question(questionText: "Название какой монетки происходит от слова 'сто'?",
                                     answerSet: ["Копейка", "Шиллинг", "Пфеннинг", "Цент"],
                                     rightAnswer: .d),
                            Question(questionText: "В каких войсках воевал литературный герой Твардовского Василий Тёркин?",
                                     answerSet: ["Пехота", "Авиация", "Кавалерия", "Артиллерия"],
                                     rightAnswer: .a),
                            Question(questionText: "Какой стране принадлежит остров Таити?",
                                     answerSet: ["Англия", "Франция", "Испания", "Бельгия"],
                                     rightAnswer: .b),
                            Question(questionText: "Где можно найти Лунный камень?",
                                     answerSet: ["На Земле", "На Луне", "На Марсе", "На Венере"],
                                     rightAnswer: .a),
                            Question(questionText: "Какой титул носил белогвардейский генерал Петр Николаевич Врангель?",
                                     answerSet: ["Лорд", "Барон", "Граф", "Герцог"],
                                     rightAnswer: .b),
                            Question(questionText: "На берегу какой реки расположен г.Набережные Челны?",
                                     answerSet: ["Обь", "Кама", "Волга", "Москва"],
                                     rightAnswer: .b),
                            Question(questionText: "Что делали с хирургом в Древнем Египте, у которого пациент умирал во время операции?",
                                     answerSet: ["Казнили", "Ослепляли", "Хоронили с пациентом", "Отрубали руки"],
                                     rightAnswer: .d),
                            Question(questionText: "Сколько штатов находится на территории США?",
                                     answerSet: ["50", "51", "52", "61"],
                                     rightAnswer: .a),
                            Question(questionText: "В какой стране был построен ледокол Ермак?",
                                     answerSet: ["Россия", "Германия", "Великобритания", "Нидерланды"],
                                     rightAnswer: .c),
                            Question(questionText: "Какую часть тела древнерусского воин защищала бармица?",
                                     answerSet: ["Грудь", "Шею", "Ногу", "Голову"],
                                     rightAnswer: .b),
                            Question(questionText: "Как в России по началу назывался паровоз?",
                                     answerSet: ["Автомат", "Машина", "Самокат", "Пароход"],
                                     rightAnswer: .d)
        ]
        questionData.append(questionSet2)
        
        let questionSet3 = [Question(questionText: "Где, если верить пословице, любопытной Варваре нос оторвали?",
                                     answerSet: ["На вокзале", "На рынке", "На базаре", "На площади"],
                                     rightAnswer: .c),
                            Question(questionText: "Что, согласно примете, происходит с человеком, если он летает во сне?",
                                     answerSet: ["Растёт", "Падает", "Болеет", "Выздоравливает"],
                                     rightAnswer: .a),
                            Question(questionText: "Какие колбаски существуют на самом деле?",
                                     answerSet: ["Чоризо", "Коризо", "Моризо", "Форизо"],
                                     rightAnswer: .a),
                            Question(questionText: "Что даёт дерево сорта антоновка?",
                                     answerSet: ["Груши", "Яблоки", "Сливы", "Персики"],
                                     rightAnswer: .b),
                            Question(questionText: "Чему равен периметр ромба со стороной 2м?",
                                     answerSet: ["4м", "6м", "12м", "8м"],
                                     rightAnswer: .d),
                            Question(questionText: "Название какого города переводится как Белый холм?",
                                     answerSet: ["Актобе", "Астана", "Кызыл орда", "Караганда"],
                                     rightAnswer: .a),
                            Question(questionText: "Какой стране принадлежит знаменитый остров Пасхи?",
                                     answerSet: ["Франция", "Англия", "Чили", "Никарагуа"],
                                     rightAnswer: .c),
                            Question(questionText: "Какой орган НЕ извлекали из тела при мумификации в Древнем Египте?",
                                     answerSet: ["Мозг", "Сердце", "Печень", "Желудок"],
                                     rightAnswer: .b),
                            Question(questionText: "Что означает в переводе с французского название пирожного 'безе'?",
                                     answerSet: ["Удовольствие", "Сладость", "Вдох", "Поцелуй"],
                                     rightAnswer: .d),
                            Question(questionText: "Сколько корон у орла на гербе РФ?",
                                     answerSet: ["1", "2", "3", "4"],
                                     rightAnswer: .c),
                            Question(questionText: "Достопримечательности какого города изображены на купюре в 1000 рублей?",
                                     answerSet: ["Ярославль", "Санкт-Петербург", "Суздаль", "Новгород"],
                                     rightAnswer: .a),
                            Question(questionText: "В какой стране расположена самая высокая гора Британских островов?",
                                     answerSet: ["Англия", "Шотландия", "Судан", "Уэльс"],
                                     rightAnswer: .b),
                            Question(questionText: "Когда возникла оперетта?",
                                     answerSet: ["В начале 20 века", "В середине 19 века", "В конце 19 века", "В конце 18 века"],
                                     rightAnswer: .b),
                            Question(questionText: "Емкость магазина автомата Калашникова?",
                                     answerSet: ["27", "28", "29", "30"],
                                     rightAnswer: .d),
                            Question(questionText: "Куда впадает Терек?",
                                     answerSet: ["В Каспийское море", "В Волгу", "В Чёрное море", "В Иртыш"],
                                     rightAnswer: .a)
        ]
        questionData.append(questionSet3)
        
        for i in (0...14) {
            let questionNum = Int.random(in: 0...2)
            gameQuestions.append(questionData[questionNum][i])
        }
    }
    
}
