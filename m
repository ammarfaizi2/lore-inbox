Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129252AbRBDRnn>; Sun, 4 Feb 2001 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132089AbRBDRn1>; Sun, 4 Feb 2001 12:43:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42767 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131889AbRBDRnM>; Sun, 4 Feb 2001 12:43:12 -0500
Subject: Re: ACPI broken in 2.4.1
To: blc@q.dyndns.org (Benson Chow)
Date: Sun, 4 Feb 2001 17:44:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, tmh@magenta-logic.com
In-Reply-To: <Pine.LNX.4.31.0102041029180.5795-100000@q.dyndns.org> from "Benson Chow" at Feb 04, 2001 10:39:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PTCn-0001ve-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I waited out the boot so I could login and experiment, but it was
> painfully slow.
> 
> Compiling with just APM in and no ACPI, results in a correctly-running
> machine with rh7 gcc-2.96-69.

Lots of people are seeing this. Stick to APM for now until the acpi folks fix
it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
