Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266942AbRGHRky>; Sun, 8 Jul 2001 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266943AbRGHRko>; Sun, 8 Jul 2001 13:40:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51730 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266942AbRGHRkc>; Sun, 8 Jul 2001 13:40:32 -0400
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
To: pavel@suse.cz (Pavel Machek)
Date: Sun, 8 Jul 2001 18:37:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), srwalter@yahoo.com (Steven Walter),
        andyw@edafio.com (Andy Ward), linux-kernel@vger.kernel.org
In-Reply-To: <20010630135804.A142@toy.ucw.cz> from "Pavel Machek" at Jun 30, 2001 01:58:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15JIVD-0000Qc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > possible on the memory bus. Several people have reported that machines that
> > are otherwise stable on the bios fast options require  the proper conservative
> > settings to be stable with the Athlon optimisations
> 
> Do we need patch to memtest to use 3dnow?

Possibly yes. Although memtest86 really tries to test for onchip not bus
related problems

