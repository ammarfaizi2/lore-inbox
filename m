Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQLGN4b>; Thu, 7 Dec 2000 08:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLGN4V>; Thu, 7 Dec 2000 08:56:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129370AbQLGN4O>; Thu, 7 Dec 2000 08:56:14 -0500
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
To: scole@lanl.gov
Date: Thu, 7 Dec 2000 13:28:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <00120609041800.00919@spc.esa.lanl.gov> from "Steven Cole" at Dec 06, 2000 09:04:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14415o-0002PJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I copied the cs46xx.c driver from 2.4.0-test11 to 2.4.0-test11-ac1,
> rebuilt, and I got a test11-ac1 kernel which works with KDE 2.0 and sound.

Excellent, that really narrows it down. Once 2.2.18 is out I will try and
get to the bottom of this
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
