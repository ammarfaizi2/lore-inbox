Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSD0NvQ>; Sat, 27 Apr 2002 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314093AbSD0NvP>; Sat, 27 Apr 2002 09:51:15 -0400
Received: from ch-12-44-141-235.lcisp.com ([12.44.141.235]:12417 "EHLO
	dual.lcisp.com") by vger.kernel.org with ESMTP id <S314083AbSD0NvL>;
	Sat, 27 Apr 2002 09:51:11 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Date: Sat, 27 Apr 2002 08:51:00 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALAEHKIEAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020427125551.GG10849@niksula.cs.hut.fi>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need an IDE controller that supports ATA133.  For most existing
computers, that is going to require a new card.-----Original Message-----


From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ville Herva
Sent: Saturday, April 27, 2002 7:56 AM
To: Martin Bene; linux-kernel@vger.kernel.org
Subject: 48-bit IDE [Re: 160gb disk showing up as 137gb]


On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
>
> IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> 160GB.
>
> (...) however, you can do something about the linux ATA driver: code
> is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.

But which IDE controllers support 48-bit addressing? Not all of them? Does
linux IDE driver support 48-bit for all of them? Do they require BIOS
upgrade in order to operate 48-bit?

Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
box I have and be done with it?



