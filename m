Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSGEU4C>; Fri, 5 Jul 2002 16:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSGEU4B>; Fri, 5 Jul 2002 16:56:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21252 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317571AbSGEU4A>; Fri, 5 Jul 2002 16:56:00 -0400
Subject: Re: StackPages errors (CALLTRACE)
To: exilion@yifan.net (Pablo Fischer)
Date: Fri, 5 Jul 2002 22:21:48 +0100 (BST)
Cc: paubert@iram.es (Gabriel Paubert), linux-kernel@vger.kernel.org
In-Reply-To: <IDEJJDGBFBNEKLNKFPAEIEAHCDAA.exilion@yifan.net> from "Pablo Fischer" at Jul 05, 2002 10:47:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17QaWS-0004F3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >you are loading is compiled for PPro or higher.
> 
> 1) Whats that? the CMMOV?..
> 2) Could I fix it with the kernel?.. YES, how?. Please Im newbie and I would
> like to fix it.

The module you have is faulty. Get the open source replacement stuff for the alcatel 
code and it might actually work
