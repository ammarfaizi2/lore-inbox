Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288188AbSACEDV>; Wed, 2 Jan 2002 23:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288186AbSACEDL>; Wed, 2 Jan 2002 23:03:11 -0500
Received: from ns.suse.de ([213.95.15.193]:8452 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288189AbSACEDI>;
	Wed, 2 Jan 2002 23:03:08 -0500
Date: Thu, 3 Jan 2002 05:03:07 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Cameron Simpson <cs@zip.com.au>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au>
Message-ID: <Pine.LNX.4.33.0201030500150.6449-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Cameron Simpson wrote:

> Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
> with the kernel; in-kernel code is fundamentally in sync.

dmidecode hasn't been updated since it was written, and still works fine.
I could also name several other such tools that have never needed a
change due to kernel upgrade, so this argument is bogus.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

