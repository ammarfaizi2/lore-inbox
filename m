Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbRFTWMj>; Wed, 20 Jun 2001 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbRFTWM1>; Wed, 20 Jun 2001 18:12:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262681AbRFTWMR>; Wed, 20 Jun 2001 18:12:17 -0400
Subject: Re: is there a linux running on jvm arch ?
To: popo.enlighted@free.fr (FORT David)
Date: Wed, 20 Jun 2001 23:11:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3B311519.3090401@free.fr> from "FORT David" at Jun 20, 2001 11:26:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CqCJ-0000Co-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I 've tested the User Mode Linux a few times ago, and it gave me an 
> idea: given the fact that we had a GCC which
> produce bytecode from C, it would be possible to produce a port of 
> linux(a new directory "jvm" in the arch dir) which
> would run in a Java Virtual Machine. (after some inquiries such compiler 
> does not exist :-( )
> I'm dreaming of a linux booting in a browser applet(imagine sending such 
> thing in a mail to MS peoples !!!!)

The JVM is very very bad from a C language point of view. You can convert C
code to it and there have been some very experimental demos of this. However
it is a very non trivial problem

Alan

