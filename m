Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129489AbRBNV1k>; Wed, 14 Feb 2001 16:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130501AbRBNV1b>; Wed, 14 Feb 2001 16:27:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129489AbRBNV1W>; Wed, 14 Feb 2001 16:27:22 -0500
Subject: Re: MP-Table mappings
To: pgpkeys@hislinuxbox.com (David D.W. Downey)
Date: Wed, 14 Feb 2001 21:28:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102141309420.5538-100000@ns-01.hislinuxbox.com> from "David D.W. Downey" at Feb 14, 2001 01:12:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T9T3-00067H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In my dmesg I'm getting duplicate table reservations.

Just a crap bios

> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000

I think the required OEM ID and product id speak volumes for the rest
of the quality issues

> Is this an issue?

Once is correct, twice is fine, zero times would be bad.

Its ok
