Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbVKXA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbVKXA6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbVKXA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:58:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:41949 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030553AbVKXA6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:58:15 -0500
Date: Wed, 23 Nov 2005 16:57:56 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch 00/22] PCI, USB and hwmon patches for 2.6.15-rc2-git
Message-ID: <20051124005756.GA1716@kroah.com>
References: <20051123234335.GA527@kroah.com> <Pine.LNX.4.64.0511231600090.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231600090.13959@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:01:36PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 23 Nov 2005, Greg Kroah-Hartman wrote:
> >
> > Here are a few PCI, USB, hwmon, and documentation patches against your
> > latest git tree, they have all been in the past few -mm releases just
> > fine.
> 
> Is there any reason you don't use git to sync up?

I did use git to make sure these patches all applied cleanly to your
latest tree.

I wasn't using git to send stuff to you after -rc1, as it makes me make
extra sure the stuff is really needed.  Just a hold-over from when I
thought we weren't supposed to use git to send stuff to you after -rc1.

If it's easier for you, I can use git to send you these, and future
patches.

thanks,

greg k-h
