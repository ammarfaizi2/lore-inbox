Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSGLTsI>; Fri, 12 Jul 2002 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGLTsH>; Fri, 12 Jul 2002 15:48:07 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:32488 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316820AbSGLTsG>; Fri, 12 Jul 2002 15:48:06 -0400
Date: Fri, 12 Jul 2002 21:49:23 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207121949.g6CJnNOj018428@burner.fokus.gmd.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From alan@lxorguk.ukuu.org.uk Fri Jul 12 21:43:27 2002

>On Fri, 2002-07-12 at 20:37, Joerg Schilling wrote:
>> >o       Many ide floppy devices can do ATAPI but get it horribly wrong
>> 
>> Describe the problems.

>Go read the source code, do your own homework

Fine! You repeat that you have no argument that stands a check.
So let us take it as prooven that there is no problem with resent
(< 10 year old) drives. 

>> 
>> Sorry, this has nothing to do with dev_t

>It has a huge amount to do with dev_t. It should be immediately obvious
>why dev_t is a critical factor in getting that interface working in a
>sane fashion.


If a sane driver interface depends on dev_t being 32 bits, then there
would be a lot og junk in the Linux kernel :-(

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
