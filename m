Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTAOMwz>; Wed, 15 Jan 2003 07:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTAOMwz>; Wed, 15 Jan 2003 07:52:55 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:9207 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S266298AbTAOMwy> convert rfc822-to-8bit; Wed, 15 Jan 2003 07:52:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: SA <bullet.train@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: silly kernel taint question
Date: Wed, 15 Jan 2003 13:04:20 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301151304.20502.bullet.train@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel list,

sorry for the stupid question but:

My kernel module contains the line,

MODULE_LICENSE("GPL");

and when I insmod it I get
Installing device driver
Warning: loading pi_stage.o will taint the kernel: forced load

kernel 2.4.18-3

   ( if I miss out the MODULE_LICENSE("GPL"); I get a different error
     Installing device driver
    Warning: loading pi_stage.o will taint the kernel: no license
    Warning: loading pi_stage.o will taint the kernel: forced load)

Any suggestions?

Thanks SA
