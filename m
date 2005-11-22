Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVKVThL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVKVThL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVKVThL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:37:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:34240 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965134AbVKVThI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:37:08 -0500
Date: Tue, 22 Nov 2005 11:05:05 -0800
From: Greg KH <greg@kroah.com>
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122190505.GA12269@kroah.com>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <pan.2005.11.22.18.26.54.534251@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.11.22.18.26.54.534251@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 07:26:55PM +0100, Matthieu CASTET wrote:
> Hi,
> 
> Le Mon, 21 Nov 2005 15:01:41 -0800, Greg KH a ?crit?:
> 
> > If you, or your company is relying on closed source kernel modules, your
> > days are numbered.  And what are you going to do, and how are you going
> > to explain things to your bosses and your customers, if possibly,
> > something like this patch were to be accepted?
> > 
> Why not make a crappy GPL driver that just export again
> the symbols ?
> 
> MODULE_LICENSE("GPL");

Because that's just so obviously illegal that anyone caught doing that
would have no defense at all :)

thanks,

greg k-h
