Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUHIOXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUHIOXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266617AbUHIOVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:21:34 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:64961 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266584AbUHIOUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:20:53 -0400
Date: Mon, 9 Aug 2004 16:20:11 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091420.i79EKBEu010574@burner.fokus.fraunhofer.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.fraunhofer.de
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, vonbrand@inf.utfsm.cl
Subject: Re: Linux Kernel bug report (includes fix)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>

>> As you don't know how kernel/user interfaces are handled, it would be wise for 
>> you to keep quiet.....

>Linux kernel include files are not meant to be used by user
>applications. He's perfectly correct. Glibc has its own exported set.
>This is intentional to seperate internals from user space.

You should know that GLIBc is unrelated to the Linux kernel interfaces we are 
talking about. Start using serious arguments please.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
