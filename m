Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288002AbSABXez>; Wed, 2 Jan 2002 18:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbSABXdi>; Wed, 2 Jan 2002 18:33:38 -0500
Received: from ns.suse.de ([213.95.15.193]:16900 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288001AbSABXbp>;
	Wed, 2 Jan 2002 18:31:45 -0500
Date: Thu, 3 Jan 2002 00:31:33 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <dalgoda@ix.netcom.com>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <E16LucJ-0005xU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201030030450.5131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Alan Cox wrote:

> > What's wrong with a startup routine that includes something like:
> > dmidecode > /var/run/dmi
> Absolutely nothing, and that also handily means it isnt setuid  8)

Indeed, it's perfect. Except no distro does it (yet), but it's
definitly the best idea so far in this thread.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

