Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbSABVIe>; Wed, 2 Jan 2002 16:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbSABVIY>; Wed, 2 Jan 2002 16:08:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51981 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281921AbSABVIR>; Wed, 2 Jan 2002 16:08:17 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 21:19:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102154633.A15671@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 03:46:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Lsn2-0005XV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the machine and set ISA_CARDS based on the probe.  What's a DMI table and
> how can I query it for the presence of ISA slots?

RTFG ;)

> What I want to do with this is make ISA-card questions invisible on modern
> PCI-only motherboards.

For the smart config I assume not in general ?

ftp://ftp.linux.org.uk/pub/linux/alan has a GPL DMI scanning app and library

Alan
