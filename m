Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLGRIz>; Thu, 7 Dec 2000 12:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130077AbQLGRIp>; Thu, 7 Dec 2000 12:08:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53771 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129908AbQLGRI3>; Thu, 7 Dec 2000 12:08:29 -0500
Subject: Re: D-LINK DFE-530-TX
To: marco@esi.it (Marco Colombo)
Date: Thu, 7 Dec 2000 16:39:07 +0000 (GMT)
Cc: jbourne@MtRoyal.AB.CA (James Bourne),
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.21.0012071722040.17276-100000@Megathlon.ESI> from "Marco Colombo" at Dec 07, 2000 05:28:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14444b-0002eT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Should be the rtl8139 driver.
> 
> AFAIK, it uses the via-rhine driver. The DFE-538TX is rtl8139 based.
> Mike, if you have problems, search list archives: a few people (including
> me) reported problems under load. I've never solved them.

2.2.18pre24 has the 8139too driver that Jeff Garzik built from a mix of his 
own work and Don Becker's rather unreliable rtl8129.c driver. It seems to be
way better (but not perfect)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
