Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317609AbSFMMvq>; Thu, 13 Jun 2002 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317608AbSFMMvp>; Thu, 13 Jun 2002 08:51:45 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:19873 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S317599AbSFMMvo>; Thu, 13 Jun 2002 08:51:44 -0400
Subject: Re: Serverworks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Daniela Engert <dani@ngrt.de>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020613112932.C2B8C10A1B@mail.medav.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jun 2002 14:52:33 +0200
Message-Id: <1023972754.23630.916.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-06-13 um 14.32 schrieb Daniela Engert:

> I have no idea if the same is happening in case of an aborted ATA DMA
> transfer (I have no bad disk around), but at least I will disable ATAPI
> DMA transfers in my driver in case of early revision (whatever this is)
> OSB4 systems - possibly on all OSB4 systems. According to your
> experiences, the CSB5 and later seem to be fine.

Sorry, bad wording. I meant "OSB4" as opposed to "CSB5/6".

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





