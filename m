Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271844AbRIVQaj>; Sat, 22 Sep 2001 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRIVQaa>; Sat, 22 Sep 2001 12:30:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50700 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271818AbRIVQaQ>; Sat, 22 Sep 2001 12:30:16 -0400
Subject: Re: Linux Kernel 2.2.20-pre10 Initial Impressions
To: jlmales@softhome.net
Date: Sat, 22 Sep 2001 17:35:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA7D82D.21744.63CF95@localhost> from "John L. Males" at Sep 18, 2001 11:26:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpkm-0003dx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I finially had a chance to compile the 2.2.20-pre10 Kernel and
> run it though some basic paces.  I need to do more specific A vs b
> (against the 2.2.19 Kernel), but it seems there are some performance
> issues.  It is seems especially obvious with Netscape 4.78.  I also
> had a odd Xfree error, that may have had some relationship to the
> performance issue.  I have to say at this point the issue seems
> selective and not a general one, but I need to do a bit more
> checking.  I cannot forsee this checking happening until this
> weekend.

There are to all intents no VM changes of any kind between 2.2.19 and
2.2.20pre10, so it would be interesting to compare configure options
and see what else might be different
