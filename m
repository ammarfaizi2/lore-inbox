Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131111AbQLLNFB>; Tue, 12 Dec 2000 08:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbQLLNEv>; Tue, 12 Dec 2000 08:04:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7429 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131111AbQLLNEl>; Tue, 12 Dec 2000 08:04:41 -0500
Subject: Re: 2.2.18pre24 spurious diskchanges
To: xavier.bestel@free.fr (Xavier Bestel)
Date: Tue, 12 Dec 2000 12:36:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012120828.JAA04872@microsoft.com> from "Xavier Bestel" at Dec 12, 2000 07:28:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145ofX-000190-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on my ide CDROm I get, roughly each 2 seconds, disk changes although the
> drive is empty and I don't touch it:

some drives report a disk change every time they are asked when empty. This
confuses magicdev somewhat
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
