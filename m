Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129931AbQK0Xsh>; Mon, 27 Nov 2000 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130319AbQK0XsV>; Mon, 27 Nov 2000 18:48:21 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:25360 "EHLO
        mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
        id <S130383AbQK0XsM>; Mon, 27 Nov 2000 18:48:12 -0500
Date: 28 Nov 2000 00:10:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7qhCHlbmw-B@khms.westfalen.de>
In-Reply-To: <E13xBNJ-0001r5-00@the-village.bc.nu>
Subject: Re: VGA PCI IO port reservations
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <8v4oe5$vbl$1@cesium.transmeta.com> <E13xBNJ-0001r5-00@the-village.bc.nu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 18.11.00 in <E13xBNJ-0001r5-00@the-village.bc.nu>:

> > It is.  There are plenty of devices for which an arbitrary IN is an
> > irrecoverable state transition.
>
> The ne2000 clones being the most infamous of them. Blind ISA read probing is
> not a safe business

Hell, I've had machines crashing in the BIOS pre-boot stuff because it was  
doing INs where a NE2000 sat.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
