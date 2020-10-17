//
//  DataProvider.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

final class DataProvider {
    //MARK: - Mock Data

    func getMovies() -> [Movie] {
        return [Movie(title: "Donnie Brasco", year: 1997, rate: 75, genre: "Crimen", budget: 35000000.00, overview: "Basada en hechos reales, narra la historia del agente del FBI, Joe Pistone, que abandona temporalmente a su familia y se hace pasar por gángster, el joyero Donnie Brasco, y que para ser aceptado por los mafiosos debe probar su lealtad y su disposición para cometer crímenes. Para acceder al corazón de las actividades del clan de los Bonnano, Donnie se gana la confianza de Lefty Ruggiero, un cínico pistolero en decadencia que nunca consiguió entrar en las altas esferas del poder."),
                Movie(title: "La Haine", year: 1995, rate: 81, genre: "Drama", budget: 2600000.00, overview: "Tras una caótica noche de disturbios en un suburbio marginal de París, tres jóvenes amigos, Vinz, Hubert y Saïd, deambulan desocupados esperando noticias sobre el estado de salud de un amigo común que ha resultado gravemente herido al enfrentarse a la policía…"),
                Movie(title: "Taxi Driver", year: 1976, rate: 82, genre: "Crimen", budget: 1300000.00, overview: "Para sobrellevar el insomnio crónico que sufre después de su regreso de Vietnam, Travis decide trabajar como taxista nocturno. Como individuo tiene poco contacto con la gente, pero observa la violencia y desolación en la que se hunde la ciudad de Nueva York. Travis anota en su diario todas sus impresiones, hasta que un día decide pasar a la acción.")]
    }
}
