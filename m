Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTJ1TyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTJ1TyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:54:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:43477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261645AbTJ1TyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:54:21 -0500
Date: Tue, 28 Oct 2003 11:53:23 -0800
From: Greg KH <greg@kroah.com>
To: John Cherry <cherry@osdl.org>
Cc: Mark Bellon <mbellon@mvista.com>, Pat Mochel <mochel@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net, cgl_discussion@osdl.org
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
Message-ID: <20031028195323.GA7822@kroah.com>
References: <Pine.LNX.4.44.0310271343170.13116-100000@cherise> <3F9DA5A6.3020008@mvista.com> <20031027233934.GA3408@kroah.com> <3F9EABC1.9070009@mvista.com> <20031028181707.GA7225@kroah.com> <1067370055.27022.29.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067370055.27022.29.camel@cherrytest.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 11:40:55AM -0800, John Cherry wrote:
> As Lars stated in an earlier email, "Competition is good, but only if
> they explore distinct approaches".  It is a shame that much effort has
> been duplicated here on similar approaches.  I'm not fully aware of the
> history behind the divergence, but it makes sense to enumerate NOW what
> is lacking in udev from a uSDE perspective.

I'm not aware of why there was a divergence in the first place either :)

As udev has been public for a long time now, would someone from Monta
Vista care to detail why they found udev lacking and deserving of a
duplicate effort?

> One objective of the carrier grade initiative is to prevent duplicate
> effort.  Now that we have two implementations, let's get the
> issues/differences on the table and cooperatively move to convergence.

I'm trying :)

greg k-h
