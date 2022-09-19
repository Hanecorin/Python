# %load metrics.py
import matplotlib.pyplot as plt
from sklearn.metrics import (accuracy_score, recall_score, f1_score, precision_score, 
                             roc_auc_score, RocCurveDisplay, roc_curve,
                             precision_recall_curve, average_precision_score, PrecisionRecallDisplay, 
                             mean_squared_error, r2_score)


def print_classification_metrics(y, pred, title=None):
    """
    인수로 받은 정답(y), 모델 예측값(pred)를 이용해 분류의 평가지표들을 출력
    출력할 평가지표: accuracy, recall, precision, f1 score
    [parameter]
        y: ndarray - 정답(Ground Truth)
        pred: ndarray - 모델이 예측한 값
        title: str - 출력결과들에 대한 제목
    [Return]
    [Exception]
    """
    print('='*50)
    if title:
        print(title)
        print('-'*50)
    print('정확도(Accuracy):', accuracy_score(y, pred))
    print('재현율/민감도(Recall):', recall_score(y, pred))
    print('정밀도(Precision):', precision_score(y, pred))
    print('F1 점수(F1 Score):', f1_score(y, pred))
    print('='*50)
    
def display_roc_curve(y, pred_proba, title=None):
    """
    ROC 커브를 시각화하는 함수
    [parameter]
        y: ndarray - 정답
        pred_proba: ndarray - 모델이 예측한 Positive확률
        title: str - 제목
    """
    roc_auc = roc_auc_score(y, pred_proba)
    fpr, tpr, _ = roc_curve(y, pred_proba)
    disp = RocCurveDisplay(fpr=fpr, tpr=tpr, roc_auc=roc_auc)
    disp.plot()
    
    if title:
        plt.title(title)
    plt.show()    
    
    
def display_precision_recall_curve(y, pred_proba, title=None):
    """
    Precision Recall 커브를 시각화하는 함수
    [parameter]
        y: ndarray - 정답 Label
        pred_proba: ndarray - 모델이 예측한 Positive의 확률
        title: str - 그래프 제목
    """
    ap_score = average_precision_score(y, pred_proba)
    precision, recall, _ = precision_recall_curve(y, pred_proba)
    disp = PrecisionRecallDisplay(precision, recall, average_precision=ap_score)
    disp.plot()
    if title:
        plt.title(title)
    plt.show()
    
    
def print_regression_metrics(y, y_pred, title=None):
    """
    회귀에대한 평가지표를 출력하는 함수 
    mse, rmse, r2 값을 계산해서 출력
    [Parameter]
        y: ndarray - 정답 배열
        y_pred: ndarray - 모델이 예측한 배열
        title: str - 제목
    """
    mse = mean_squared_error(y, y_pred)
    rmse = mean_squared_error(y, y_pred, squared=False)
    r2 = r2_score(y, y_pred)
    if title:
        print(title)
    print(f"MSE:{mse}, RMSE:{rmse}, R Square:{r2}")  
    
