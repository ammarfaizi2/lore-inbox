Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSGGWfG>; Sun, 7 Jul 2002 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSGGWfE>; Sun, 7 Jul 2002 18:35:04 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:15847 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S316600AbSGGWeo>; Sun, 7 Jul 2002 18:34:44 -0400
Subject: Reg. segmentation fault on sparc with gcc-3.0 (ld)
From: Shanti Katta <katta@csee.wvu.edu>
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jul 2002 18:43:13 -0400
Message-Id: <1026081797.7057.10.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When I try to compile user-mode-linux on UltraSparc-I, I get the
following error message during linking:

gcc-3.0 -o mk_task mk_task_user.o mk_task_kern.o
collect2: ld terminated with signal 11 [Segmentation fault], core dumped

I could not get any help regarding this error on the web. Is it because
of some sparc 32/64 oddities or it has something to do with the
compiler?

Any pointers will be appreciated

Thank you,
-Regards
-Shanti

