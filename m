Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUHVUPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUHVUPB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUHVUPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:15:01 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:446 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268163AbUHVUOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:14:55 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 22 Aug 2004 22:14:12 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-ID: <4128FE94.nail9U42DA799@burner>
References: <2vge2-63k-15@gated-at.bofh.it>
 <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
 <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
 <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
 <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <20040822192646.GH19768@thundrix.ch>
In-Reply-To: <20040822192646.GH19768@thundrix.ch>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> In Solaris DTrace is enabled in _normal production_ kernel and you can 
>> hang any probe or probes set without restarting system or any runed
>> application which was compiled withoud debug info.
>
>Solaris only runs on large computers. You don't want kprobes randomly on
>your phone, pda, wireless router. Solaris deals with an extremely narrow
>market segment of "big computers for people with lots of money".
...
>> http://blogs.sun.com/roller/page/bmc/20040820#dtrace_on_lkml
>> Bryan blog is also yet another Dtrace knowledge source ..
>
>Coo I thought only the Sun CEO spent his life making inappropriate
>comments 8)

It seems that Alan does not like to miss a single day to degrade his 
credibiltiy :-(

A fact based discussion looks different...

-	What is a "large computer"?

-	What is an "extremely narrow market segment"?
	What is the evidence of this statement compared to Linux?

-	What are the minimum requirements for a machine to run Linux?

-	What are the minimum requirements for a machine to run Solaris?

People who cannot answer these questions should not try to start mad
speculations on derived conclusions.

The size of the loadable dtrace module is ~ 100 kB, this is nothing bad even 
for small appliances these days.

Guess what Brian Cantrill is running on his notebook?

Guess what machine Brian is using to run dtrace demos on shows?

And hey, Brian is even able to make a 4 hour demo within a single hour on this 
machine ;-)

Dtrace is a powerful idea that gives unbelievable new opportinities to 
developers, sysadmins and users. 


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
