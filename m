Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSAXTPH>; Thu, 24 Jan 2002 14:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288951AbSAXTO5>; Thu, 24 Jan 2002 14:14:57 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:17676 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S288950AbSAXTOl>;
	Thu, 24 Jan 2002 14:14:41 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15440.23830.178152.579775@abasin.nj.nec.com>
Date: Thu, 24 Jan 2002 14:14:30 -0500 (EST)
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS and RAID5
In-Reply-To: <20020124200645.53dca41c.skraw@ithnet.com>
In-Reply-To: <15440.22127.875361.718680@abasin.nj.nec.com>
	<20020124200645.53dca41c.skraw@ithnet.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:
 > On Thu, 24 Jan 2002 13:46:07 -0500 (EST)
 > Sven Heinicke <sven@research.nj.nec.com> wrote:
 > 
 > > 
 > > We had a drive go bad on a RAID5 with reiserfs on it.  The file system
 > > was built with reiserfsprogs-3.x.0h tools and the systems was running
 > > Linux 2.4.13.  As we had an issue it will be updated to the latest
 > > kernel, it had been stable up to now.
 > 
 > Would you mind to be a bit more specific about the hardware involved, 
 > especially the RAID5, SMP etc?
 > This is not HW-RAID5, is it?
 > 


Software RAID .. Yes

System got two:

vendor_id	: GenuineIntel
model name	: Pentium III (Coppermine)
cpu MHz		: 868.671
cache size	: 256 KB

It's an ASLab system with 4 Ultra100 Cards each with 4 80G maxtor
drives.  So with the video and network card the PCI slots are full.
The raid tools are raidtools-0.90-9mdk as shipped with Mandrake 7.2.

