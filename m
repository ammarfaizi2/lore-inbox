Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUE0AlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUE0AlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUE0AlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 20:41:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:11190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261443AbUE0AlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 20:41:13 -0400
Date: Wed, 26 May 2004 17:26:19 -0700
From: Greg KH <greg@kroah.com>
To: Zenaan Harkness <zen@freedbms.net>
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: [Fwd: Re: drivers DB and id/ info registration]
Message-ID: <20040527002619.GA7385@kroah.com>
References: <1085548092.2909.60.camel@zen8100a.freedbms.net> <20040526182919.GA25978@kroah.com> <1085600051.2468.17.camel@zen8100a.freedbms.net> <20040526195505.GB2588@kroah.com> <1085602088.2466.24.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085602088.2466.24.camel@zen8100a.freedbms.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 06:08:08AM +1000, Zenaan Harkness wrote:
> 
> Hmm, I guess lkml is going to be pretty well kernel-centric.

Hasn't it always been?  :)

> Are you saying "it'll be ripped out and discarded forever" or
> "ripped out and placed in userspace where it always shoulda been"?

"Ripped out as it is already in userspace where it belongs".  Look in
the package that provides your 'lspci' binary.

> I'm still not convinced that having comprehensive device recognition
> is pointless (but I'm not trying to push something that excludes
> drivers here either ...).

That's fine.  Again, talk to the HAL people, they are working on this.

Good luck,

greg k-h
