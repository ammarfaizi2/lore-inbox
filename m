Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273818AbRJBNht>; Tue, 2 Oct 2001 09:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273819AbRJBNh3>; Tue, 2 Oct 2001 09:37:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273818AbRJBNh1>; Tue, 2 Oct 2001 09:37:27 -0400
Subject: Re: Athlon optimized kernels?
To: devilkin@gmx.net (DevilKin)
Date: Tue, 2 Oct 2001 14:43:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011002115402.00ad1c88@pop.gmx.net> from "DevilKin" at Oct 02, 2001 11:56:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oPp8-0004fX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been hearing a lot here lately about optimized kernels for Athlons. Is 
> this a kernel patch of some sort? And where can I find it - as I have a 
> thunderbird system, I would love to try those out and help finding bugs in it!

The 2.4 kernels can be built with athlon optimised prefetch and memory
copying. Pretty much all of the athlon related stuff is in Linus tree now
(actually it may even all be there). 

Alan
