Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbSAMP2g>; Sun, 13 Jan 2002 10:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbSAMP21>; Sun, 13 Jan 2002 10:28:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285745AbSAMP2P>; Sun, 13 Jan 2002 10:28:15 -0500
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
To: andreas@xss.co.at (Andreas Haumer)
Date: Sun, 13 Jan 2002 15:39:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        reid.hekman@ndsu.nodak.edu (Reid Hekman), linux-kernel@vger.kernel.org
In-Reply-To: <3C417364.5358BEDD@xss.co.at> from "Andreas Haumer" at Jan 13, 2002 12:45:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Pmjk-0007FH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> switch. To see if it's a hardware problem I already switched
> back to 2.2.18 once, and the problem went away.
> Under 2.2.20 I have to boot with "noapic" to have it running
> smoothly.

Does 2.2.19 work ?
