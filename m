Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270267AbRHNKBG>; Tue, 14 Aug 2001 06:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270384AbRHNKA5>; Tue, 14 Aug 2001 06:00:57 -0400
Received: from mail.webmaster.com ([216.152.64.131]:50054 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270272AbRHNKAt>; Tue, 14 Aug 2001 06:00:49 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <joseph.bueno@trader.com>, "Mircea Ciocan" <mirceac@interplus.ro>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: Is there something that can be done against this ???
Date: Tue, 14 Aug 2001 03:00:58 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMKENKDCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
In-Reply-To: <3B78DE6D.E8DB6B7C@trader.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The question is not : "is this script dangerous ?",
> but "are you ready to blindly execute a shell script
> (or any program) that you receive in your  mail ?".

	Sure, as a user created solely for that purpose, it should be entirely
safe.

> I don't care if this script is dangerous or not because I will
> never execute it,
> or any program that I receive my email before checking its
> contents and making sure
> it is OK.
> (And my mail reader will not execute anything automatically, not
> even Javascript).

	Why? Is it because you don't trust your system security? Your operating
system shouldn't let the script do anything you don't want it to do.

> If somebody is dumb enough to execute any  program received by email,
> don't loose time trying to find some weaknesses in the system; just
> send him a shell script with "rm -rf /". It will do enough harm !

	That should do no harm. What you mean to say is "if somebody is dumb enough
to execute any program recieved by email under a user account that has
permissions to modify files he cares about, consume too many process slots,
consume excessive vm, or has other special capabilities".

> Best protection against mail virus is not technical (although it
> may help),
> but user education; and this is true regardless of which operating system
> or mail reader is used !

	If a user can run code that can harm the system, then nobody who isn't
trusted not to harm the system can be a user. That's not how we want Linux
to be, is it?

	DS

