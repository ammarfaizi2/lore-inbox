Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSHCUlX>; Sat, 3 Aug 2002 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSHCUlW>; Sat, 3 Aug 2002 16:41:22 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:52491 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S317735AbSHCUlV>;
	Sat, 3 Aug 2002 16:41:21 -0400
Date: Sat, 3 Aug 2002 22:44:34 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: i8xx series patches for 2.5.30
Message-ID: <20020803224434.A18671@medelec.uia.ac.be>
References: <20020803221425.A18344@medelec.uia.ac.be> <1028411429.1761.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028411429.1761.36.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Aug 03, 2002 at 10:50:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > 3) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-3.txt
> > This patch adds a set of defines to pci_ids.h for 82801E and 82801DB I/O Controller Hub PCI-IDS.
> > I could not add them all since two of them existed allready for the IDE controllers, but the naming was not ideal. That's why patch 5 and 6 corrects this.
> > 
> 
> Corrects as in "uses my opinion of right" or corrects as in "matches
> 2.4" ?

corrects as in "matches 2.4" and as in "it's more logical in my opinion".

Greetings,
Wim.

