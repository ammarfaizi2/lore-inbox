Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbQLPTNu>; Sat, 16 Dec 2000 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132236AbQLPTNk>; Sat, 16 Dec 2000 14:13:40 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:1029 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S132130AbQLPTNa>;
	Sat, 16 Dec 2000 14:13:30 -0500
Date: Sat, 16 Dec 2000 19:42:20 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200012161842.TAA21775@db0bm.ampr.org>
To: kaos@ocs.com.au
Subject: Re: 2.4.0-test13-pre2, unresolved symbols
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

Keith Owens wrote :
>>/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
>>/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol
>>rpc_wake_up_task

>Does this fix it?

Yes, _this_ problem is fixed, thank you.

Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
