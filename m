Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287965AbSABVCF>; Wed, 2 Jan 2002 16:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287967AbSABVBu>; Wed, 2 Jan 2002 16:01:50 -0500
Received: from ns.suse.de ([213.95.15.193]:15366 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287985AbSABVAx>;
	Wed, 2 Jan 2002 16:00:53 -0500
Date: Wed, 2 Jan 2002 22:00:52 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <esr@thyrsus.com>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <E16LsU0-0005RB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201022200070.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Alan Cox wrote:

> You can make an educated guess. However it is at best an educated guess.
> The DMI tables will tell you what PCI and ISA slots are present (but
> tend to be unreliable on older boxes).

And newer ones. I've seen 'Full length ISA slot' reported on a laptop
for eg.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

