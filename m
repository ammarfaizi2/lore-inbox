Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317712AbSHCU3H>; Sat, 3 Aug 2002 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317714AbSHCU3H>; Sat, 3 Aug 2002 16:29:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48884 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317712AbSHCU3G>; Sat, 3 Aug 2002 16:29:06 -0400
Subject: Re: i8xx series patches for 2.5.30
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020803221425.A18344@medelec.uia.ac.be>
References: <20020803221425.A18344@medelec.uia.ac.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 22:50:29 +0100
Message-Id: <1028411429.1761.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 21:14, Wim Van Sebroeck wrote:
> 3) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-3.txt
> This patch adds a set of defines to pci_ids.h for 82801E and 82801DB I/O Controller Hub PCI-IDS.
> I could not add them all since two of them existed allready for the IDE controllers, but the naming was not ideal. That's why patch 5 and 6 corrects this.
> 

Corrects as in "uses my opinion of right" or corrects as in "matches
2.4" ?


