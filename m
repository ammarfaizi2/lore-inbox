Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbSABVRZ>; Wed, 2 Jan 2002 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284301AbSABVRR>; Wed, 2 Jan 2002 16:17:17 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:35865 "EHLO
	apone.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284186AbSABVPt>; Wed, 2 Jan 2002 16:15:49 -0500
Date: Wed, 2 Jan 2002 16:23:49 -0500
From: Bill Nottingham <notting@redhat.com>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102162349.A957@apone.devel.redhat.com>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16LsU0-0005RB-00@the-village.bc.nu> <Pine.LNX.4.33.0201022200070.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201022200070.427-100000@Appserv.suse.de>; from davej@suse.de on Wed, Jan 02, 2002 at 10:00:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (davej@suse.de) said: 
> > You can make an educated guess. However it is at best an educated guess.
> > The DMI tables will tell you what PCI and ISA slots are present (but
> > tend to be unreliable on older boxes).
> 
> And newer ones. I've seen 'Full length ISA slot' reported on a laptop
> for eg.

I have an ia64 here that, according to dmidecode, has a
32bit NUBUS slot in it. AFAIK, that's not the case. ;)

Bill
