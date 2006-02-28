Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWB1A07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWB1A07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWB1A07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:26:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:17817 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751806AbWB1A06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:26:58 -0500
Date: Mon, 27 Feb 2006 16:26:37 -0800
From: Greg KH <gregkh@suse.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, davej@redhat.com, perex@suse.cz, kay.sievers@vrfy.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060228002637.GA23195@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227203520.0df1d548.diegocg@gmail.com> <20060227194941.GD9991@suse.de> <20060227205759.4a7c7c13.diegocg@gmail.com> <20060227200041.GA11400@suse.de> <20060227211315.e7a04524.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227211315.e7a04524.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 09:13:15PM +0100, Diego Calleja wrote:
> El Mon, 27 Feb 2006 12:00:41 -0800,
> Greg KH <gregkh@suse.de> escribi?:
> 
> > No, look at the different descriptions that I gave them in the README
> > please.  They are very different.  If you think the wording there is not
> > precise enough, could you suggest some other wording?
> 
> 
> Maybe "Developers should not release stable versions of userspace
> applications which depend on "unstable" interfaces, they're only
> good for development versions, if you need to use a "unstable"
> interface for your program you should wait at least until it hits
> "testing" (or even better, "stable")"; or something like that.

So, we will be forcing this scheme onto userspace programmers too?  Yeah
right, this isn't Solaris :)

thanks,

greg k-h
