Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSFRP6k>; Tue, 18 Jun 2002 11:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSFRP6j>; Tue, 18 Jun 2002 11:58:39 -0400
Received: from cm61-18-96-140.hkcable.com.hk ([61.18.96.140]:63244 "EHLO
	mail.tropic.net") by vger.kernel.org with ESMTP id <S317462AbSFRP6i>;
	Tue, 18 Jun 2002 11:58:38 -0400
Message-ID: <009601c216e0$fa64f180$1532a8c0@private.tropic.net>
From: "Hans E. Kristiansen" <hans@tropic.net>
To: "Kai Germaschewski" <kai@tp1.ruhr-uni-bochum.de>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206180931410.5695-100000@chaos.physics.uiowa.edu>
Subject: Re: 2.5.22 problems with compile.h
Date: Tue, 18 Jun 2002 23:58:03 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied your patch which was included in an earlier email on the advice
from Mr. Martin Deal, and it works! Can't ask for more. At last I can go
back to my userland programming.

Perhaps the real problem is that Linus released 2.5.22 on a Monday :)

TTFN,
Hans E.

----- Original Message -----
From: "Kai Germaschewski" <kai@tp1.ruhr-uni-bochum.de>
To: "Hans E. Kristiansen" <hans@tropic.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, June 18, 2002 22:36
Subject: Re: 2.5.22 problems with compile.h


> On Tue, 18 Jun 2002, Hans E. Kristiansen wrote:
>
> > >From a clean install, I can compile, but I get an error with compile.h
(Do
> > not know how to make compile.h). If I compile again, I get a working
kernel
> > (bzImage), "depmod -ae -F xx " works like a charm. But, when I reboot
with

--- snip ----

