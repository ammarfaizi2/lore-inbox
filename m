Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266764AbRGFR0r>; Fri, 6 Jul 2001 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbRGFR0h>; Fri, 6 Jul 2001 13:26:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25860 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266764AbRGFR0W>; Fri, 6 Jul 2001 13:26:22 -0400
Subject: Re: [patch] Fix warnings in videobook
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Fri, 6 Jul 2001 18:26:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010706192232.D25204@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Jul 06, 2001 07:22:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IZMs-0004eu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All of which can be fixed by changing <> into <entry>. Patch applies
> cleanly against 2.4.6, 2.4.7-pre3, and 2.4.6-ac1. Please apply, it even
> makes the tables visible :)

That looks like tool problems. <></> is valid SGML short format, are you
using XML docbook ?

I'll apply them anyway - they do no harm and short form SGML is evil in some
books ;)

