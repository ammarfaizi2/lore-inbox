Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315930AbSEGSJF>; Tue, 7 May 2002 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315931AbSEGSJE>; Tue, 7 May 2002 14:09:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31748 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315930AbSEGSI6>; Tue, 7 May 2002 14:08:58 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 7 May 2002 19:26:29 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), benh@kernel.crashing.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0205071103040.975-100000@home.transmeta.com> from "Linus Torvalds" at May 07, 2002 11:05:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1759fR-0008Dg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Fugly. What's wrong with readlink(2) as this "magic syscall"?
> Ehh - like the fact that it doesn't work on device files?

I can't find anything in Posix/SuS that says it isnt allowed to however 8)
