Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289405AbSAOWCe>; Tue, 15 Jan 2002 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289689AbSAOWCY>; Tue, 15 Jan 2002 17:02:24 -0500
Received: from 203-79-66-98.adsl-wns.paradise.net.nz ([203.79.66.98]:30082
	"HELO volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S289405AbSAOWCO>; Tue, 15 Jan 2002 17:02:14 -0500
Date: Wed, 16 Jan 2002 11:02:11 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020115220211.GE598@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz> <20020115214049.GI51648@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115214049.GI51648@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:40:49PM +0200, Ville Herva wrote:
> 
> Hmm, do the pci ids map somehow to physical pci slots? It seems one

Im not sure. Someone in the mailing list should know though. 8)

> particular physical pci slot location is troublesome in our case. It caused
> problems with nic and even with a scsi adapter. Unfortunately I can't
> remember which slot it was - I'll have to check (I _think_ it was the third
> counting from bottom).
> 
> So I'm interested in the physical location of you nic...

Ok. I can't check the machine in Wellington, but in the machine here.
Not couting the AGP slot, the NIC is sitting in the third slot in the
back of the box.


I'd have to open it (later today when the office is closed) to comfirm
its sitting in the 'third' PCI slot from the CPU.  

The NIC is the only PCI card in this machines. The video card being a
basic AGP one. (This is the other difference with the machine in
Wellington which has an old but expensive PCI video card.)


The problem with moving the card, is that the problem exhibits very
slowly. After the previous problems with the Seagate drive reseting and
the computer finally crashing majorly I replaced the drive and
everything seemed fine.

Only now have I notice the problems.

-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 1612865 

                         Quixotic Eccentricity
