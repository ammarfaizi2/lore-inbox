Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270600AbRIBXxq>; Sun, 2 Sep 2001 19:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270615AbRIBXxh>; Sun, 2 Sep 2001 19:53:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9229 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270600AbRIBXx3>; Sun, 2 Sep 2001 19:53:29 -0400
Subject: Re: pvr2fb.c
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Mon, 3 Sep 2001 00:57:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <Pine.GSO.4.33.0109021930580.23852-100000@sweetums.bluetronic.net> from "Ricky Beam" at Sep 02, 2001 07:35:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dh74-0000d0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PS: Compiling 2.4.9 on an Alpha is turning up all manner of weird stuff.  Like
>     a lot of drivers that aren't 64bit clean, missing parts of asm-alpha...

Linus should have the main missing bits of asm-alpha in 2.4.10pre - although
on x86 that crashes rapidly for me. 
