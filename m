Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317928AbSGKXEw>; Thu, 11 Jul 2002 19:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317930AbSGKXEv>; Thu, 11 Jul 2002 19:04:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45582 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317928AbSGKXEu>; Thu, 11 Jul 2002 19:04:50 -0400
Subject: Re: ATAPI + cdwriter problem
To: mistral@stev.org (James Stevenson)
Date: Fri, 12 Jul 2002 00:31:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
       linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <000d01c2292d$d46e70f0$0501a8c0@Stev.org> from "James Stevenson" at Jul 11, 2002 11:53:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SnOw-0001pS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > i also have now tried this under 2.4.19-rc1 which produces the same
> > > problems.
> >
> > Apply the diff below then retry. Let people know if it fixes your atapi
> > problem
> 
> no it doesnt

Thanks - ok that one is an open question for Promise I guess
