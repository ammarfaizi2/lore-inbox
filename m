Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287510AbRLaNDq>; Mon, 31 Dec 2001 08:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287509AbRLaNDh>; Mon, 31 Dec 2001 08:03:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34318 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287508AbRLaNDY>; Mon, 31 Dec 2001 08:03:24 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
To: bryce@obviously.com (Bryce Nesbitt)
Date: Mon, 31 Dec 2001 13:13:44 +0000 (GMT)
Cc: Lionel.Bouton@free.fr (Lionel Bouton), Andries.Brouwer@cwi.nl,
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3C2FC84E.79DB9B9@obviously.com> from "Bryce Nesbitt" at Dec 30, 2001 09:07:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L2G8-00050T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone want the first few K of this DVD to see why the autodetection
> is not working better?  Do you want me to upgrade past Kernel 2.4.2-2 first?
> Is RedHat 7.2's kernel good enough?

The autodetection is working. Your DVD has a UDF file system on it and a
blank iso9660 one.
