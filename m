Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132086AbQLHN1T>; Fri, 8 Dec 2000 08:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbQLHN1K>; Fri, 8 Dec 2000 08:27:10 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:5384 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S132086AbQLHN06>; Fri, 8 Dec 2000 08:26:58 -0500
From: sswapnee@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA2569AF.00470FB0.00@d73mta05.au.ibm.com>
Date: Fri, 8 Dec 2000 18:16:00 +0530
Subject: Unresolved symbol problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am new to linux world and currently learning to write device drivers and
modules.  This question might have been
repeated many times on the list but I havent found any satisfactory answer
in the archives hence I am posting this question
again.  While loading the module, the insmod complains about several
unresolved symbols namely securebits, printk, dput, d_alloc_root,
__generic_copy_to_user etc.  I am not using any of these but still I am
getting the errors.  Can someone please
tell me why am I getting this error?  How to resolve this error?

I am using Linux 2.4.0-test10 on Intel Pentium box.

Thanking you in anticipation
Swapneel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
