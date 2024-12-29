# License Plate Detection and Recognition Using YOLOv5 and PaddleOCR

This project implements a pipeline for detecting and recognizing license plates using YOLOv5 for detection and PaddleOCR for optical character recognition (OCR). It integrates Flask for a web-based interface and supports database storage for results, making it a robust system for license plate analysis.

---

## Features

1. **License Plate Detection**  
   YOLOv5 detects license plates in images or videos.  
   - Pretrained model: `best_1.pt` (stored in `Backend/OCR/ocr/`).

2. **License Plate Recognition**  
   PaddleOCR extracts text from detected license plates.  
   - Inference models are located in `Backend/OCR/ocr/models/`.

3. **Web Interface**  
   A Flask-based web application displays detected and recognized license plate data.

4. **Database Integration**  
   Preprocessed results are stored in a database for further use.  
   - Schema: `SQLQuery1.sql`.

5. **Model Retraining**  
   YOLOv5 can be retrained with new data, and the `.pt` file can be replaced in `Backend/OCR/ocr/`.

---

## Setup and Usage

### 1. **Prepare the Environment**
   - Install the required dependencies:
     ```bash
     pip install -r requirements.txt
     ```
   - Activate the virtual environment:
     ```bash
     activate.bat
     ```

### 2. **Start the Flask App**
   - Run the Flask app using:
     ```bash
     startflask.bat
     ```

### 3. **Run the License Detection Script**
   - Execute `license.py` after the Flask app is running:
     ```bash
     python license.py
     ```

### 4. **Provide Input Video**
   - Place the video file for processing in `Backend/OCR/ocr/`.
   - Update the file path in `license.py` as needed.

### 5. **Database Setup**
   - Ensure the database is running.
   - Configure database connection names in the `server` section of `license.py` (line 21).
   - Use the schema defined in `SQLQuery1.sql` to create the database structure.

### 6. **Access the Web Interface**
   - Navigate to `http://127.0.0.1:5000/` to view detected license plate data after preprocessing.

---

## Workflow

1. Start the Flask app and run `license.py`.
2. The YOLOv5 model (`best_1.pt`) detects license plates in the video.
3. PaddleOCR extracts text from the detected plates.
4. Preprocessing is applied to enhance recognition accuracy.
5. Results are stored in the database and can be viewed via the web interface.
6. For new training, replace the `.pt` file in `Backend/OCR/ocr/` after training YOLOv5.

---

## Important Notes

- **Video Input**: Place input videos in the `Backend/OCR/ocr/` folder and adjust the path in `license.py`.
- **YOLOv5 Model**: Trained model is stored as `best_1.pt` in `Backend/OCR/ocr/`. Replace this file for updated model usage.
- **Results**: Outputs, including preprocessed data, are saved in the `runs` folder within YOLOv5.
- **Database Configuration**: Update database connection details in `license.py` (line 21).
- **PaddleOCR Inference**: OCR models are stored in `Backend/OCR/ocr/models/`.

---

## Future Improvements

- Add real-time video processing capability.
- Expand OCR support for multilingual license plates.
- Develop an admin dashboard for managing and analyzing stored data.

---

## Acknowledgments

- **YOLOv5** for license plate detection ([Ultralytics YOLOv5](https://github.com/ultralytics/yolov5)).
- **PaddleOCR** for text recognition ([PaddleOCR](https://github.com/rohanvenkatesha/PaddleOCR).

Feel free to fork, contribute, or raise issues for further enhancements! 🚗💻
