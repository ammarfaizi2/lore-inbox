Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRAXRVO>; Wed, 24 Jan 2001 12:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbRAXRUy>; Wed, 24 Jan 2001 12:20:54 -0500
Received: from [212.255.16.226] ([212.255.16.226]:16365 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S131984AbRAXRUc> convert rfc822-to-8bit;
	Wed, 24 Jan 2001 12:20:32 -0500
Message-ID: <008f01c08629$f2582d20$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>
In-Reply-To: <E14LOAm-0006z0-00@the-village.bc.nu> <E14LOAm-0006z0-00@the-village.bc.nu> <01012416081105.19999@nessie> <20010124170337Z129710-18594+930@vger.kernel.org>
Subject: Re: NTFS safety and lack thereof - Was: Re: Linux 2.4.0ac11
Date: Wed, 24 Jan 2001 17:09:49 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
> Isn't it still theoretcially possible for the driver to send commands to the
> disk controller that cause data to become overwritten, even when it's just
> supposed to read that data?

IMHO the NTFS driver creators weren't bloody newbies and won't do such
a bug, even not by accidence.
Also I think there might be a VFS protection of R/O space, but I'm not sure.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
