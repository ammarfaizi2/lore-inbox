Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266385AbRGBGlM>; Mon, 2 Jul 2001 02:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266386AbRGBGlD>; Mon, 2 Jul 2001 02:41:03 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:36106 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266385AbRGBGko>;
	Mon, 2 Jul 2001 02:40:44 -0400
Date: Sun, 1 Jul 2001 23:39:42 -0700
From: Greg KH <greg@kroah.com>
To: Jakob Borg <jakob@borg.pp.se>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Keyboard errors with 2.4.5-ac
Message-ID: <20010701233942.D22232@kroah.com>
In-Reply-To: <3B3CBA86.355500A@inet.com> <20010630194835.A730@borg.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010630194835.A730@borg.pp.se>; from jakob@borg.pp.se on Sat, Jun 30, 2001 at 07:48:36PM +0200
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 07:48:36PM +0200, Jakob Borg wrote:
> On Fri, Jun 29, 2001 at 12:27:34PM -0500, Jordan Breeding wrote:
> > lock a couple of times then the keyboard stops responding completely and
> > the kernel tells me that there was an error waiting on a IRQ on CPU #1. 
> 
> You are using an SMP kernel. In my experience, nothing USB works with an SMP
> kernel >2.4.3.

Hm, that's a pretty vague statement :)
I'm happily running USB on a few SMP machines around here.  What are the
problems that you are having?

thanks,

greg k-h
