Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbREOUP6>; Tue, 15 May 2001 16:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbREOUPs>; Tue, 15 May 2001 16:15:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14611 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261431AbREOUPb>; Tue, 15 May 2001 16:15:31 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 15 May 2001 21:10:47 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <200105151931.f4FJVL830847@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at May 15, 2001 01:31:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zl9b-0002x9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	len = readlink ("/proc/self/3", buffer, buflen);
> 	if (strcmp (buffer + len - 2, "cd") != 0) {
> 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> 		exit (1);

And on my box cd is the cabbage dicer whoops

What I actually want to know is 'does it do cd ioctls, can I talk scsi
commands to it, does it support cabbage dicing ..

