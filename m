Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTBJQIT>; Mon, 10 Feb 2003 11:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBJQIT>; Mon, 10 Feb 2003 11:08:19 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:20489 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S264903AbTBJQIT>; Mon, 10 Feb 2003 11:08:19 -0500
Message-ID: <005601c2d11f$bfe5e060$59951ad3@windows>
From: "James Buchanan" <jamesbuch@iprimus.com.au>
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: <linux-kernel@vger.kernel.org>
References: <001501c2d11a$3ad9c3a0$59951ad3@windows> <20030210160848.GB30804@morningstar.nowhere.lie>
Subject: Re: SMP-Linux
Date: Tue, 11 Feb 2003 03:16:18 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 10 Feb 2003 16:18:01.0888 (UTC) FILETIME=[FBD2C200:01C2D11F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why stop there?  Why not make a complete hardware abstraction layer?

NetBSD has - hasn't it?  Take a look!

> Oh, by the way, I have two words for you:
>
> DUCK!
>
> :-)

Uh oh ... ;-)

> What you are describing sounds very much like a Virtual Machine.
>
> Been there, done that, and it does have some benefits.

Yes, a HAL, very much, but not really a VM, only a very thin layer of
architecture-nuturalness.  Very thin.  The trickery I have learnt from
the NetBSD project is that it has some very clever glue code below
this HAL.  I suppose to maintain acceptable performance levels.  Then
again the goals of NetBSD and Linux are different in some respects,
Linux likes raw speed and was originally only for the x86 and NetBSD
likes portability above that.

So I suppose my experiment will never really take off, but could have
some interesting results!

--
James

