Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276697AbRJGVqM>; Sun, 7 Oct 2001 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276695AbRJGVpw>; Sun, 7 Oct 2001 17:45:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276697AbRJGVps>; Sun, 7 Oct 2001 17:45:48 -0400
Subject: Re: Linux-2.4.11-pre5
To: bunk@fs.tum.de (Adrian Bunk)
Date: Sun, 7 Oct 2001 22:48:29 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.NEB.4.40.0110072235410.3783-200000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Oct 07, 2001 10:49:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qLmf-0006xb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get the error below. Must likely there's a problem when you build a
> kernel without module support (my .config is attached).

Its a sanity checker in the module processing code. Means you (or Linus..)
need to fix the makefiles
