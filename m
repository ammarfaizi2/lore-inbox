Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSHHSSx>; Thu, 8 Aug 2002 14:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSHHSSx>; Thu, 8 Aug 2002 14:18:53 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:27910 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317539AbSHHSSv>;
	Thu, 8 Aug 2002 14:18:51 -0400
Date: Thu, 8 Aug 2002 11:19:32 -0700
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation
Message-ID: <20020808181931.GA22209@kroah.com>
References: <20020808170611.GA21821@kroah.com> <Pine.LNX.4.33.0208081326480.26999-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208081326480.26999-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 11 Jul 2002 17:16:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 01:36:35PM -0400, Scott Murray wrote:
> 
> Are you interested in this reservation code as a seperate patch for 2.4,
> or should I just send you all of my cPCI stuff to look at in one go?  I
> was going to cut it up into 3-4 patches before sending it to
> pcihpd-discuss sometime later today, but I can do whatever you want.

I'd prefer it for 2.5 right now.  But if the cPCI stuff doesn't touch
anything else, I'd be interested in that for 2.4.

I don't want to really touch the core PCI code in 2.4 right now, unless
we _really_ have to :)

> Done.  I'd considered doing that right off, but it didn't seem to match
> the style of the rest of the PCI code, for example the proc and pm stuff.
> If you want, I can work on a patch to clean those up as well.

For 2.5, I'd love a patch to do that.  As I said above, I don't really
care about that for 2.4.

thanks,

greg k-h
