Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbREPXaw>; Wed, 16 May 2001 19:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbREPXac>; Wed, 16 May 2001 19:30:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19213 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261337AbREPXa2>; Wed, 16 May 2001 19:30:28 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 17 May 2001 00:26:12 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        jlundell@pobox.com (Jonathan Lundell),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        jsimmons@transvirtual.com (James Simmons),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        neilb@cse.unsw.edu.au (Neil Brown), hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.05.10105160923370.23225-100000@callisto.of.borg> from "Geert Uytterhoeven" at May 16, 2001 09:24:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150AgG-0004bb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are FireWire (and USB) disks always detected in the same order? Or does it
> behave like ADB, where you never know which mouse/keyboard is which
> mouse/keyboard?

USB disks are required (haha etc) to have serial numbers. Firewire similarly
has unique disk identifiers.  

