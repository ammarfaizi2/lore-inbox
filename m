Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288321AbSACV1Z>; Thu, 3 Jan 2002 16:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSACV1P>; Thu, 3 Jan 2002 16:27:15 -0500
Received: from ns.suse.de ([213.95.15.193]:59150 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288325AbSACV07>;
	Thu, 3 Jan 2002 16:26:59 -0500
Date: Thu, 3 Jan 2002 22:26:55 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: <cs@zip.com.au>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <3C34C9D4.4030705@free.fr>
Message-ID: <Pine.LNX.4.33.0201032225130.13260-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Lionel Bouton wrote:

> > Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
> > with the kernel;
> Read dmidecode.c, it's an exception.

Not really. acpidmp, dump_pirq, sbf, mgainfo.. the list goes on.
The original statement above is nonsense.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

