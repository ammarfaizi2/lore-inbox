Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTAHQkC>; Wed, 8 Jan 2003 11:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbTAHQkC>; Wed, 8 Jan 2003 11:40:02 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:47249 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267366AbTAHQkB>;
	Wed, 8 Jan 2003 11:40:01 -0500
Date: Wed, 8 Jan 2003 17:48:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@pyxtechnologies.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030108174827.A28042@ucw.cz>
References: <3E1B3A49.42F6370E@linux-m68k.org> <Pine.LNX.4.10.10301071439190.421-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10301071439190.421-100000@master.linux-ide.org>; from andre@pyxtechnologies.com on Tue, Jan 07, 2003 at 02:45:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 02:45:51PM -0800, Andre Hedrick wrote:

> > Andre Hedrick wrote:
> > 
> > > Please continue to think of TCP checksums as valid for a data transport,
> > > you data will be gone soon enough.
> > > 
> > > Initiator == Controller
> > > Target == Disk
> > > iSCSI == cable or ribbon
> > > 
> > > Please turn off the CRC on your disk drive and see if you still have data.
> > 
> > This maybe works as PR, but otherwise it's crap.
> 
> So, please turn off the CRC's in your onboard storage today and see how
> long it lasts.

1) Bad comparison.

2) It'd last very very long, because I never get a CRC error anyway.

-- 
Vojtech Pavlik
SuSE Labs
