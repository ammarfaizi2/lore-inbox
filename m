Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263114AbSJBM7h>; Wed, 2 Oct 2002 08:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbSJBM7h>; Wed, 2 Oct 2002 08:59:37 -0400
Received: from mail3.WPI.EDU ([130.215.24.62]:3083 "EHLO mail3.WPI.EDU")
	by vger.kernel.org with ESMTP id <S263114AbSJBM7h>;
	Wed, 2 Oct 2002 08:59:37 -0400
From: "Seth Chandler" <sethbc@WPI.EDU>
To: <mec@shout.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: ALSA Menuconfig Breakage in 2.5.40 and 2.5.40-bk1
Date: Wed, 2 Oct 2002 09:05:01 -0400
Message-ID: <000001c26a14$5168ad60$6501a8c0@sbc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menuconfig has encountered a possible error in one of the kernel's
Configuration files and is unable to continue.  Here is the error 
report:

Q> ./scripts/Menuconfig: MCmenu74: command not found

This is broken in both 2.5.40 and 2.5.40-bk1

seth


