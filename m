Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSAQIzX>; Thu, 17 Jan 2002 03:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSAQIzQ>; Thu, 17 Jan 2002 03:55:16 -0500
Received: from aboukir-101-1-1-maz.adsl.nerim.net ([62.4.18.26]:25990 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S288377AbSAQIzD>; Thu, 17 Jan 2002 03:55:03 -0500
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
In-Reply-To: <20020117015456.A628@thyrsus.com>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 17 Jan 2002 09:54:39 +0100
Message-ID: <wrppu492w8g.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20020117015456.A628@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eric" == Eric S Raymond <esr@thyrsus.com> writes:

Eric> Does anything in /proc or elswhere reliably register the
Eric> presence of EISA?

On my dual PPro, /proc/pci shows :

  Bus  0, device   2, function  0:
    Non-VGA unclassified device: Intel Corp. 82375EB (rev 21).
      Master Capable.  Latency=248.  

This is a PCI-EISA bridge.

Eric> Failing that, have any motherboards existed that had both PCI
Eric> and EISA slots?

I have two of this kind : This dual Pentium Pro (Nec motherboard), and
a Digital AlphaServer 1000.

Most high-end Pentium-Pro motherboard had both PCI and EISA slots.

Regards,

        Marc.
-- 
Places change, faces change. Life is so very strange.
