Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSGTTZk>; Sat, 20 Jul 2002 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSGTTZk>; Sat, 20 Jul 2002 15:25:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:9739 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317002AbSGTTZk>;
	Sat, 20 Jul 2002 15:25:40 -0400
Date: Sat, 20 Jul 2002 12:26:59 -0700
From: Greg KH <greg@kroah.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: [USB] uhci-hcd oops on APM resume (2.5.23-26)
Message-ID: <20020720192659.GA27715@kroah.com>
References: <20020719194326.GA23137@kroah.com> <Pine.LNX.4.44.0207192306030.5859-100000@loke.as.arizona.edu> <20020720143653.B23737@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020720143653.B23737@sventech.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 22 Jun 2002 18:25:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2002 at 02:36:53PM -0400, Johannes Erdfelt wrote:
> On Fri, Jul 19, 2002, Craig Kulesa <ckulesa@as.arizona.edu> wrote:
> > Excellent.  The patch from Jan Harkes that you posted 
> > (http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/1463.html)
> > worked wonderfully for me.  No more rogue USB disconnects on APM resume, 
> > and no more oopses. 
> > 
> > Any hopes for sending it Linus-ward? ;)
> 
> FWIW Greg, this patch is correct. Thanks!

Great, I'll send it off in the next round of patches.  Craig, thanks for
testing it out.

greg k-h
