#pragma once
#include "__dep__.h"
#include "constants.h"
#include "marshallable.h"


namespace janus {
class CmdData : public Marshallable {
 public:
//  static map<cmdtype_t, function<TxData*()>>& Initializers();
//  static int RegInitializer(cmdtype_t, function<TxData*()>);
//  static function<TxData*()> GetInitializer(cmdtype_t);

  cmdid_t id_ = 0;
  cmdtype_t type_ = 0;
  innid_t inn_id_ = 0;
  cmdid_t root_id_ = 0;
  cmdtype_t root_type_ = 0;
//  TxData* self_cmd_ = nullptr; // point to actual stuff.

 public:
  virtual innid_t inn_id() const {return inn_id_;}
  virtual cmdtype_t type() {return type_;};
  virtual void Arrest() {verify(0);};
  virtual CmdData& Execute() {verify(0);};
  virtual void Merge(CmdData&){verify(0);};;
  virtual bool IsFinished(){verify(0);};

  virtual set<parid_t> GetPartitionIds() {
    verify(0);
    return set<parid_t>();
  }

  virtual bool HasMoreSubCmdReadyNotOut() {
    verify(0);
    return false;
  }

  virtual CmdData* GetNextReadySubCmd(){verify(0);};
  virtual CmdData* GetRootCmd() {return this;};
  virtual void Reset() {verify(0);};
  virtual CmdData* Clone() const  {
    verify(0);
//    TxData* c = GetInitializer(type_)();
//    *c = *this;
//    c->self_cmd_ = c;
//    return c;
  };

  CmdData() : Marshallable(MarshallDeputy::CONTAINER_CMD) {}
  virtual ~CmdData() {};
  virtual Marshal& ToMarshal(Marshal&) const override;
  virtual Marshal& FromMarshal(Marshal&) override;
};
} // namespace janus
