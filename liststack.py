class Stack:
    def __init__(self):
        self.list_items = list()
        self.length = 0
    def push(self,d):
        print(str(d)+" is pushed.")
        self.list_items.append(d)
        self.length+=1
    def pop(self):
        if self.length<1:
            return None
        k = self.list_items.pop()
        print(str(k)+" is popped out.")
        self.length-=1
    def __len__(self):
        return self.length
    def printStack(self):
        t = len(self)-1
        while t>=0:
            print(self.list_items[t],end=" ")
            t-=1
        print()
s = Stack()
s.push(6)
s.push(4)
s.push(3)
s.printStack()
s.pop()
s.printStack()
