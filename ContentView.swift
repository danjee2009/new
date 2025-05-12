import SwiftUI

struct planitem : Identifiable{
    var id = UUID()
    var name : String
    var ischecked :Bool
}
    
struct ContentView: View {
    
    @State private var text : String = ""
    @State public var plan : [planitem] = []
    @State private var showsheet : Bool = false
    @State private var ischecked : Bool = false
    @State private var showalert : Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("LIST")
                        .font(.title)
                }
                
                List{
                    ForEach($plan){$planitem in
                        HStack{
                            Button(action:{
                                planitem.ischecked.toggle()
                            }){
                                Image(systemName: planitem.ischecked ? "checkmark.square" : "square")
                                
                            }
                            .foregroundColor(planitem.ischecked ? .gray : .black)
                            
                            Text(planitem.name)
                                .foregroundColor(planitem.ischecked ? .gray : .black)
                                .strikethrough(planitem.ischecked, color : .gray)
                            
                            Spacer()
                            
                            Button(action:{
                                delete(item:planitem)
                            }){
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action:{
                        showsheet.toggle()
                    }){
                        Image(systemName: "plus")
                            .frame(width: 40,height: 40)
                            .font(.title)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }.sheet(isPresented:$showsheet){
                        Inputsheet()
                            .presentationDetents([.height(120), .medium])
                    }.padding()
                }
                .alert("확인", isPresented: $showalert){
                    TextField("계획 입력",text: $text)
                        .background(Color(uiColor: .secondarySystemBackground))
                    Button("취소",role: .cancel){
                    }
                    Button(action:{
                        add()
                    }){
                        Text("완료")
                    }
                }
            }
        }
    }
    func add(){
        if !text.isEmpty{
            let new = planitem(name: text, ischecked: false)
            plan.append(new)
            text=""
        }
        
    }
    func delete(item: planitem) {
        if let index = plan.firstIndex(where: { $0.id == item.id }) {
            plan.remove(at: index)
        }
    }
    
}



struct Inputsheet : View {
    
    @State var text : String = ""
    @State var li : [String] = []
    
    var body: some View {
        TextField("입력",text: $text)
            .background(Color(uiColor: .secondarySystemBackground))
            .padding()
        Button(action : add){
            Text("추가")
        }
        
        List{
            ForEach(li,id:\.self){el in
                Text(el)
            }
        }
        }
    
    func add(){
        if !text.isEmpty{
            li.append(text)
            text=""
        }
    }
        
    }
    


#Preview {
    ContentView()
}
