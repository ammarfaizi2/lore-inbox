Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130587AbRCIRV7>; Fri, 9 Mar 2001 12:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130588AbRCIRVt>; Fri, 9 Mar 2001 12:21:49 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:2828 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S130587AbRCIRVn>; Fri, 9 Mar 2001 12:21:43 -0500
Date: Fri, 9 Mar 2001 09:21:02 -0800
From: David Rees <dbr@greenhydrant.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18, Intel i815 chipset and DMA
Message-ID: <20010309092102.D13905@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010309090641.C13905@greenhydrant.com> <Pine.LNX.4.10.10103091210280.6522-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10103091210280.6522-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Fri, Mar 09, 2001 at 12:12:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 12:12:07PM -0500, Mark Hahn wrote:
> > I've got a Gateway here with a Intel 815 chipset running 2.2.18.  Inside
> 
> why?  2.2 is obsolete, and will not receive new drivers.

Hmm, so the Intel 815 and DMA doesn't mix with 2.2.x?  What about
Andre's IDE patches?

> > The problem is that the IDE driver doesn't recognize the IDE
> > conroller, so DMA isn't enabled leading to some poor drive
> 
> the controller is fine in the current 2.4.

I was hoping to stay off the 2.4 series until it stabilises a bit more,
although I may have to upgrade to get any sort of decent performance
out of this machine.  There's a reason no distributions aren't shipping
a 2.4.x kernel yet.

Thanks,
Dave
