Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131516AbQLPLDf>; Sat, 16 Dec 2000 06:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131565AbQLPLD0>; Sat, 16 Dec 2000 06:03:26 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:42002 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131516AbQLPLDP>;
	Sat, 16 Dec 2000 06:03:15 -0500
Date: Sat, 16 Dec 2000 11:32:44 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200012161032.LAA16091@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test13-pre2, unresolved symbols
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_wake_up_task
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_killall_tasks
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_init_task
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol nlmclnt_proc
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_shutdown_client
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpciod_up
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_new_task
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpciod_down
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol lockd_down
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_wake_up_status
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_clnt_sigmask
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpcauth_releasecred
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol lockd_up
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_proc_unregister
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol xdr_encode_array
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol nfs_debug
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_create_client
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_sleep_on
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpcauth_lookupcred
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_clnt_sigunmask
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_call_setup
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_call_sync
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol xprt_destroy
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_execute
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol rpc_proc_register
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol xdr_zero_iovec
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol xprt_create_proto
Using /lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol nlmsvc_ops
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol lockd_down
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol rpc_garbage_args
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol xdr_decode_string
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_exit_thread
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_proc_unregister
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol nlmsvc_invalidate_client
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol lockd_up
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol xdr_encode_array
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_makesock
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_destroy
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_create_thread
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_recv
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_process
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol xdr_one
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_create
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol nfsd_debug
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_proc_register
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol svc_proc_read
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o: unresolved symbol rpc_system_err
Using /lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
---------
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
