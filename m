Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274713AbRIUADP>; Thu, 20 Sep 2001 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274714AbRIUADF>; Thu, 20 Sep 2001 20:03:05 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:34062 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274713AbRIUADA>;
	Thu, 20 Sep 2001 20:03:00 -0400
Date: Thu, 20 Sep 2001 16:59:52 -0700
From: Greg KH <greg@kroah.com>
To: lkml@krimedawg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB hub broken between 2.4.10-pre6 and 2.4.10-pre12
Message-ID: <20010920165952.A22273@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0109190110330.590-100000@mcgruff.krimedawg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109190110330.590-100000@mcgruff.krimedawg.org>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 01:15:52AM -0700, lkml@krimedawg.org wrote:
> After upgrading from 2.4.10-pre6 and -pre12, my USB hub stopped working.
> This happens with both of the UHCI drivers.  If there's anything I can do
> to help (narrow it down to a specific release?) let me know...

It looks like your hub is working, for a while, then it starts having
problems.
Is this hub powered from the USB bus, or from an external power supply?
Does your devices still work properly plugged into the computer
directly?

thanks,

greg k-h
