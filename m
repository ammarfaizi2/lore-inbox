Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSGKVRx>; Thu, 11 Jul 2002 17:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317912AbSGKVRw>; Thu, 11 Jul 2002 17:17:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45581 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317911AbSGKVRw>; Thu, 11 Jul 2002 17:17:52 -0400
Subject: Re: ATAPI + cdwriter problem
To: andre@linux-ide.org (Andre Hedrick)
Date: Thu, 11 Jul 2002 22:38:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mistral@stev.org (James Stevenson),
       linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.10.10207111021450.16921-100000@master.linux-ide.org> from "Andre Hedrick" at Jul 11, 2002 10:22:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Sldb-0001d4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You just broke every system that is not x86 wanting to use the pci card.

I want to find out if Promise stuff fixes the problems people are having. 
Dealing with a bit of non x86 portability is something to worry about 
later. Right now both the rc1 and the rc1-ac2 promise IDE suck completely
for a lot of people. Probably more than own alphas

Alan
