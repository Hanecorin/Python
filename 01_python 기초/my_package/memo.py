def simple_memo():
    filename = input('파일명:')
    with open(filename,'wt') as fw:
        print('파일에 저장할 내용을 입력하세요.')
        print('-'*50)
        while True:
            line = input() #저장할 한줄을 입력받기
            if line == '!q':
                break
            fw.write(line+"\n")
            
if __name__=="__main__":
    simple_memo()