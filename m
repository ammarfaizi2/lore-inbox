Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSGKC77>; Wed, 10 Jul 2002 22:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGKC75>; Wed, 10 Jul 2002 22:59:57 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:20667 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317742AbSGKC70>;
	Wed, 10 Jul 2002 22:59:26 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207110259.GAA27698@sex.inr.ac.ru>
Subject: Re: [CRASH] in tulip driver?
To: jussi.laako@kolumbus.FI (Jussi Laako)
Date: Thu, 11 Jul 2002 06:59:33 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2C92C0.658B954@kolumbus.fi> from "Jussi Laako" at Jul 11, 2 00:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Any ideas what is causing the following crash?

There is no BUG() in sched.c:579 or in vicinity of this line.

So, the only idea is that the crash is caused by patches which
you applied to the kernel. :-)

Alexey

