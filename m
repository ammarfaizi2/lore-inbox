Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSF1TKk>; Fri, 28 Jun 2002 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSF1TKj>; Fri, 28 Jun 2002 15:10:39 -0400
Received: from [212.44.140.49] ([212.44.140.49]:4224 "HELO mops.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317142AbSF1TKi>;
	Fri, 28 Jun 2002 15:10:38 -0400
Message-Id: <200206281821.WAA00420@mops.inr.ac.ru>
Subject: Re: Fragment flooding in 2.4.x/2.5.x
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Fri, 28 Jun 2002 22:21:10 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206281238.40242.trond.myklebust@fys.uio.no> from "Trond Myklebust" at Jun 28, 2 12:38:39 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> suddenly jump to ~4.5MB/s (peak was 5MB/s).

Hmm.. it is funny that you were satisfied with previous value
and it is funny that it still does not saturate link.


> however I hope you agree that it shows that fixing this bug *is* worth the 
> effort.

Of course. If you noticed this year or two or three ago, it would be even
an urgent problem. But until now it was problem with status of "well-known
bogosity which requires some sane solution but can wait for some good idea
for infinite time because of absence of any real applications sensing it" :-)

Alexey
