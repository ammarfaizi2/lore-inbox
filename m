Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132102AbQKQMJY>; Fri, 17 Nov 2000 07:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbQKQMJP>; Fri, 17 Nov 2000 07:09:15 -0500
Received: from linus.st-and.ac.uk ([138.251.32.11]:53503 "EHLO
	linus.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id <S132001AbQKQMJC>; Fri, 17 Nov 2000 07:09:02 -0500
Message-Id: <l03130301b63ac8b83d39@[138.251.135.28]>
In-Reply-To: <E13wjlY-0000YD-00@the-village.bc.nu>
In-Reply-To: <l03130300b63ac27dc63a@[138.251.135.28]> from "Mark Hindley"
 at Nov 17, 2000 11:26:40 AM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 17 Nov 2000 11:38:56 +0000
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: Mark Hindley <mh15@st-andrews.ac.uk>
Subject: Re: [PATCH] ALS-110 opl3 and mpu401 under 2.4.0-test10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It changes the command line properties people already use. It also cannot be
>neccessary since 'uart401' is static.

 So why does the kernel command-line uart401=1 make a builtin uart401
driver look for the mpu at 0x1 rather than persuade the sb driver to to do
a pnp lookup for it?

Mark Hindley

Director of the Music Centre
University of St Andrews

01334 462226/7

http://www.st-andrews.ac.uk/services/music


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
