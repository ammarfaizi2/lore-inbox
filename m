Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311721AbSCXSJa>; Sun, 24 Mar 2002 13:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311709AbSCXSJW>; Sun, 24 Mar 2002 13:09:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12560 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311721AbSCXSHk>; Sun, 24 Mar 2002 13:07:40 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: linux-kernel@borntraeger.net (Christian =?iso-8859-1?q?Borntr=E4ger?=)
Date: Sun, 24 Mar 2002 18:23:48 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        alan@lxorguk.ukuu.org.uk (Alan Cox), andihartmann@freenet.de (andreas),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <200203241757.SAA20700@piggy.rz.tu-ilmenau.de> from "Christian =?iso-8859-1?q?Borntr=E4ger?=" at Mar 24, 2002 06:57:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pCei-0006tx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I think could be worth in terms of security, because a local user c=
> ould=20
> use a bad memory-eating program to produce an Denial of Service of other=20
> processes.
> 
> Unfortunately detecting a program, written to cause harm is harder than=20
> detecting a crazy program.

Its not about detection its about containment. Thats what the beancounter
patches covered.
