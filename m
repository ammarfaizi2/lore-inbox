Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287372AbSACV7N>; Thu, 3 Jan 2002 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287368AbSACV7C>; Thu, 3 Jan 2002 16:59:02 -0500
Received: from bergeron.research.canon.com.au ([203.12.172.124]:43873 "HELO
	a.mx.canon.com.au") by vger.kernel.org with SMTP id <S287366AbSACV6o>;
	Thu, 3 Jan 2002 16:58:44 -0500
Date: Fri, 4 Jan 2002 08:58:38 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104085838.A8611@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au> <E16M75s-0008Bz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16M75s-0008Bz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 03, 2002 at 12:35:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:35:36PM +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
| > Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
| > with the kernel; in-kernel code is fundamentally in sync.
| Disagree. Its reading BIOS tables not poking at kernel internals

I'll pay this one. Assuming the BIOS is always (in some guarrenteed hw
related sense) in the same place in kmem.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

The question of whether computers can think is just like the question of
whether submarines can swim.	- Edsger W. Dijkstra
