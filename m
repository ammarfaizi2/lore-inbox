Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265694AbRFXBSt>; Sat, 23 Jun 2001 21:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265695AbRFXBSj>; Sat, 23 Jun 2001 21:18:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265694AbRFXBS1>; Sat, 23 Jun 2001 21:18:27 -0400
Subject: Re: Is this part of newer filesystem hierarchy?
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Sun, 24 Jun 2001 02:17:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), stimits@idcomm.com (D. Stimits),
        linux-kernel@vger.kernel.org (kernel-list)
In-Reply-To: <Pine.LNX.4.33.0106240210540.29573-100000@Expansa.sns.it> from "Luigi Genoni" at Jun 24, 2001 02:16:01 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DyWg-00065L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The point was that Stimits says that on its Red Hat 7.1 he has no
> ldscripts directory, and so no files like elf_i386.x and so on.
> I was just surprised, since i know thay are all necessary to /usr/bin/ld
> to work.

> two libc
> /lib/libc.so.6 and /lib/i686/libc.so.6, one is tripped and the other
> contains debug symbols.


Ok that I dont know. The dynamic linker has changed a fair bit over time and
I don't know enough about it to help

