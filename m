Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUEUWgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUEUWgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUEUWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:35:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:32955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265857AbUEUWdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:52 -0400
Date: Fri, 21 May 2004 14:56:29 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040521215629.GA7121@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AE7829.9060105@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 05:44:09PM -0400, nardelli wrote:
> Greg KH wrote:
> >On Fri, May 21, 2004 at 03:51:23PM -0400, nardelli wrote:
> >
> >
> >Patch is line-wrapped, so I can't apply it :(
> >
> >
> 
> Hmmm... I couldn't see the linewrap in the original I sent, or
> in test ones that I did.  Probably my mail tool, but then it
> is getting late on a Friday, which probably means that it is me.
> 
> To aid in diagnosing where I'm goofing up, could you point out
> a spot where it is linewrapping?

Ok, my bad, sorry, mutt likes to wrap stuff when the mail has the
following header in it like yours did:
	Content-Type: text/plain; charset=us-ascii; format=flowed

Sorry about that, the patch is not wrapped.

greg k-h
