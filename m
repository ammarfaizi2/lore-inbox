Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264209AbRFXN0O>; Sun, 24 Jun 2001 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264214AbRFXNZy>; Sun, 24 Jun 2001 09:25:54 -0400
Received: from Expansa.sns.it ([192.167.206.189]:12814 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264209AbRFXNZp>;
	Sun, 24 Jun 2001 09:25:45 -0400
Date: Sun, 24 Jun 2001 15:25:36 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "D. Stimits" <stimits@idcomm.com>,
        kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <E15DyWg-00065L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106241523470.31190-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, but i followed its development till now, and those file are still
present, belive me, when i do compile latest versions.
I am doing beta test of it when i have time,
and i think i tried all versions from 2.7.... times, sometimes sending bug
reports.

On Sun, 24 Jun 2001, Alan Cox wrote:

> > The point was that Stimits says that on its Red Hat 7.1 he has no
> > ldscripts directory, and so no files like elf_i386.x and so on.
> > I was just surprised, since i know thay are all necessary to /usr/bin/ld
> > to work.
>
> > two libc
> > /lib/libc.so.6 and /lib/i686/libc.so.6, one is tripped and the other
> > contains debug symbols.
>
>
> Ok that I dont know. The dynamic linker has changed a fair bit over time and
> I don't know enough about it to help
>

