Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVCBXMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVCBXMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVCBXLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:11:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:10726 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261298AbVCBXEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:04:23 -0500
Date: Wed, 2 Mar 2005 15:04:01 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302230400.GA9394@kroah.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/me kills my patchbomb script for now

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> 
>  - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
>    patches leading up to it (timeframe: a week or two)
> 
> with the odd numbers going like:
> 
>  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
>    to it (timeframe: a month or two).

Ok, that's acceptable to me, but realize that this puts a bigger burden
on the maintainers to queue up patches for you.  It's not that big of a
deal, just something to be aware of.

Speaking of which, does this mean I shouldn't hit you with all of my
pending stuff?  I know some of the other subsystem maintainers have a
lot of stuff queued up too.  Should we start this new numbering scheme
as of today?  Or wait until 2.6.13?

thanks,

greg k-h
