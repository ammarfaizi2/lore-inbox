Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbTCZSYy>; Wed, 26 Mar 2003 13:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbTCZSYy>; Wed, 26 Mar 2003 13:24:54 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53765 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261784AbTCZSYx>;
	Wed, 26 Mar 2003 13:24:53 -0500
Date: Wed, 26 Mar 2003 10:35:14 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: torvalds@transmeta.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.66
Message-ID: <20030326183514.GD24689@kroah.com>
References: <20030326005417.GA19868@kroah.com> <Pine.LNX.3.96.1030326131317.8110E-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030326131317.8110E-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 01:17:56PM -0500, Bill Davidsen wrote:
> On Tue, 25 Mar 2003, Greg KH wrote:
> 
> > Hi,
> > 
> > Here are some small USB changes.  Basically all little cleanups and
> > bugfixes, nothing major.
> > 
> > Please pull from:  bk://linuxusb.bkbits.net/linus-2.5
> 
> Another "bk-only" patch. Guess I'd better look at the free (as in license,
> not cost) clone again.

Not true at all (as I've stated many times in the past...)

The USB patches that I send to Linus through BK are all sent to the
linux-usb-devel mailing list as followups to this message.

They are also placed at kernel.org in:
	/pub/linux/kernel/people/gregkh/usb/2.5/*.2.5.66*

So no, I always provide patches, I just don't flood lkml with USB
specific ones.

thanks,

greg k-h
