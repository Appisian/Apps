package com.example.appisian.myapplication.questions;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.appisian.myapplication.Question;
import com.example.appisian.myapplication.R;

import java.util.ArrayList;

import me.drakeet.materialdialog.MaterialDialog;

/**
 * Created by Appisian on 14/02/2017.
 */

public class QuestionsAdapter extends RecyclerView.Adapter<QuestionsAdapter.QuestionViewHolder> {

    private ArrayList<Question> questions;

    public QuestionsAdapter(ArrayList<Question> questions) {
        this.questions = questions;
    }
    @Override
    public QuestionViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        final Context ctx = parent.getContext();
        final LayoutInflater inflater = LayoutInflater.from(ctx);
        final View questionItemView = inflater.inflate(R.layout.question_item, parent, false);
        return new QuestionViewHolder(questionItemView);
    }

    @Override
    public void onBindViewHolder(QuestionViewHolder holder, int position) {
        final Question question = questions.get(position);
        final Context ctxItem = holder.itemView.getContext();

        // Set content
        holder.questionText.setText(question.question);
        holder.categoryQuestion.setText(question.category);
        holder.difficultyQuestion.setText(question.difficulty_name);


        switch (question.difficulty_name){
            case "easy":
                holder.difficultyImage.setImageResource(R.drawable.easy);
                break;
            case "medium":
                holder.difficultyImage.setImageResource(R.drawable.medium);
                break;
            case "hard":
                holder.difficultyImage.setImageResource(R.drawable.hard);
                break;

        }





        final MaterialDialog mMaterialDialog = new MaterialDialog(ctxItem);
        mMaterialDialog.setTitle("Réponse");
        mMaterialDialog.setMessage("");
        mMaterialDialog.setPositiveButton("OK", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mMaterialDialog.dismiss();
            }
        });


        holder.itemView.setOnLongClickListener(new View.OnLongClickListener() {

            @Override
            public boolean onLongClick(View v) {
                Log.d("test", question.correct_answer);
                mMaterialDialog.setMessage(question.correct_answer);

                mMaterialDialog.show();


                return true;
            }
        });
    }

    @Override
    public int getItemCount() {
        return questions.size();
    }

    class QuestionViewHolder extends RecyclerView.ViewHolder {
        TextView questionText;
        TextView categoryQuestion;
        TextView difficultyQuestion;
        ImageView difficultyImage;

        public QuestionViewHolder(View itemView) {
            super(itemView);
            this.questionText = (TextView) itemView.findViewById(R.id.question_text);
            this.categoryQuestion = (TextView) itemView.findViewById(R.id.catergory_question);
            this.difficultyQuestion = (TextView) itemView.findViewById(R.id.difficulty_question);
            this.difficultyImage = (ImageView) itemView.findViewById(R.id.difficulty_image);
        }
    }

}

