//
//  TutorialTestViews.swift
//  Clew
//
//  Created by Declan Ketchum on 6/21/21.
//  Copyright © 2021 OccamLab. All rights reserved.
//

import SwiftUI

struct TutorialTestView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("CLEW Tutorial")
                
                NavigationLink(destination: OrientPhone()) {Text("Holding Your Phone")}
                
                NavigationLink(destination: SetAnchorPoint()) {Text("Setting an Anchor Point")}
                
                NavigationLink(destination: SignleUse()) {Text("Using a Signle Use Route")}

            }
        }
    }
}

struct OrientPhone: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Holding Your Phone")
            
                Text("For best expereince using CLEW you will have to hold your phone virtically, dirrectly infront of your chest with the rear camera facing forward. This is because CLEW uses your phones camera to track where you move so that it can take you back along the same route")
                
                NavigationLink(destination: SetAnchorPoint()) {Text("Next")}
            }
        }
    }
}

struct SetAnchorPoint: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Setting an Anchor Point")
            
                Text("To allow your route to be navigated at a later pointyou need to record an anchor point for the start of your route...")
            
                NavigationLink(destination: SignleUse())  {Text("Next")}
            }
        }
    }
}

struct SignleUse: View {
    var body: some View {
        VStack{
            Text("Using a Signle Use Route")
            
            Text("")
        }
    }
}




struct TutorialTestViews_Previews: PreviewProvider {
    static var previews: some View {
        TutorialTestView()
    }
}
