Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSLUSWT>; Sat, 21 Dec 2002 13:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLUSWT>; Sat, 21 Dec 2002 13:22:19 -0500
Received: from virgo.i-cable.com ([203.83.111.75]:27302 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id <S262826AbSLUSWS>;
	Sat, 21 Dec 2002 13:22:18 -0500
From: "Sampson Fung" <sampson@attglobal.net>
To: "'John Bradford'" <john@grabjohn.com>,
       "'Sampson Fung'" <sampson.fung@attglobal.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How to help new comers trying the v2.5x series kernels.
Date: Sun, 22 Dec 2002 02:30:13 +0800
Message-ID: <000b01c2a91f$01324ff0$0100a8c0@noelpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <200212211816.gBLIG3NV000880@darkstar.example.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of John Bradford
> Sent: Sunday, December 22, 2002 2:08 AM
> To: Sampson Fung
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: How to help new comers trying the v2.5x series kernels.
> 
> 
> > From v2.5.49 up, I can only test the compiled kernel, if it 
> compiles 
> > at all, with modules disabled completely. Of course, I have to say 
> > that I do not try much before v2.5.49.
> > 
> > I think new comers, myselft included, can make use of standard 
> > templates of kernel .config file.
> 
> Try a minimal configuration, or the default one, (which is 
> whatever Linus uses).  Avoid modular IDE for now.
> 
Where is the default .config?  I am eager to have a try.

> > First of all, "standard templates" are tested that they will be 
> > compiled without problem. They should be able to boot.
> > They should have a working "framework" of "modules", for 
> example, lsmod
> > works without any problem.  (And any other "required" 
> modutils as well)
> > They shuold supports further kernel compile. (With small incremental
> > changes to the base "standard template").
> 
> Sounds like an excellent job for a new kernel hacker to take on board
> - why not make the standard templates yourself, and post them 
> to the list for each 2.5.x tree.  It *would* be quite useful, 
> and save a lot of developers' time, for example, it would 
> stop a lot of people complaining about modular IDE.
> 

I can post my config as I am using common hardware config.
But I cannot make the "framework" of "modules" working for me.

> > Then I can try to compile my lan card as modules.
> > Then try to compile my SCSI card, etc, etc.
> > 
> > Does similar "standard templates" exist already?
> 
> No.
> 
> > Where can I search for known bugs centrally, so that I can 
> help myself 
> > as much as possible?
> 
> * The mailing list archives
> * Kernel Bugzilla
> * (hopefully in a week or so) my new bug database which I am currently
>   writing.
> 
> John.

Sampson


