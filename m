Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUF2Tp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUF2Tp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUF2Tp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:45:29 -0400
Received: from havoc.gtf.org ([216.162.42.101]:2513 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265955AbUF2Tp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:45:27 -0400
Date: Tue, 29 Jun 2004 15:45:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: Updated Wireless Extension patches
Message-ID: <20040629194525.GF23191@havoc.gtf.org>
References: <20040629162339.GA4356@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629162339.GA4356@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 09:23:39AM -0700, Jean Tourrilhes wrote:
> 	Hi all,
> 
> 	I've been working a bit more on my current set of Wireless
> Extension patches (WPA, Wireless-RtNetlink, ...). I've just updated
> them on my personal web page :
> 	http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html#wext
> 
> 	The main change is that I'm now happy of the format of
> Wireless over RtNetlink, so it should be close to definitive. I've
> also split all the minor changes as a separate patch (WE-17), so it
> doesn't have to wait for WPA and Wireless-RtNetlink that still need a
> bit of work, and I plan to push this patch soon.
> 	You will also find patches for various drivers to take
> advantage of the new features. I would like to thank the various
> driver authors that sent me patches, suggestions and comments, and
> thank them for their patience.

Regardless of our recent discussions, I do want to emphasize that I wish
to maintain the current WE, and its backwards compatibility, for the
current 2.6.x stable series at the very least.

So please don't be discouraged from submitting WE patches...

	Jeff


P.S. do associated userland wireless-tools patches exist to make use of
netlink?  i.e. how have you been testing it?
