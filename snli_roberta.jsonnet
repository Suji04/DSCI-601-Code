local transformer_model = "roberta-large";
local transformer_dim = 1024;

{
  "dataset_reader":{
    "type": "snli",
    "tokenizer": {
      "type": "pretrained_transformer",
      "model_name": transformer_model,
      "add_special_tokens": false
    },
    "token_indexers": {
      "tokens": {
        "type": "pretrained_transformer",
        "model_name": transformer_model,
        "max_length": 512
      }
    }
  },
  "train_data_path": "data/t_data_3.jsonl",
  "validation_data_path": "data/v_data_3.jsonl",
  // "test_data_path": "data/snli_1.0_test.jsonl",
  "model": {
    "type": "from_archive", 
    "archive_file": "https://storage.googleapis.com/allennlp-public-models/snli-roberta-2020-07-29.tar.gz"
    },
 
  "data_loader": {
    "batch_sampler": {
      "type": "bucket",
      "batch_size" : 32
    }
  },
  "trainer": {
    "num_epochs": 10,
    "validation_metric": "+accuracy",
    "learning_rate_scheduler": {
      "type": "slanted_triangular",
      "cut_frac": 0.06
    },
    "optimizer": {
      "type": "huggingface_adamw",
      "lr": 2e-5,
      "weight_decay": 0.1,
    }
  }
}
