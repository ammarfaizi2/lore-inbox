Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQLEVMD>; Tue, 5 Dec 2000 16:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130371AbQLEVLy>; Tue, 5 Dec 2000 16:11:54 -0500
Received: from sigtrap.GUUG.DE ([134.95.80.189]:37387 "EHLO sigtrap.guug.de")
	by vger.kernel.org with ESMTP id <S129786AbQLEVLl>;
	Tue, 5 Dec 2000 16:11:41 -0500
Date: Tue, 5 Dec 2000 21:34:11 +0100 (CET)
From: Winfried Truemper <winni@xpilot.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
Message-ID: <Pine.LNX.4.30.0012052123490.9137-100000@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What helped me was to use old IDE cables to enforce UDMA-33.
Switching to an 80-conductor cable makes the machine freeze
regardless of what I set in the HPT-BIOS.

Upgrading the MB BIOS, fans on the chipset and a 435 watts   :)
power supply are reported to help some cases. I had no luck.


Regards
-Winfried


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
