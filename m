Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUGUSl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUGUSl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUGUSl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:41:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:59554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266586AbUGUSlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:41:17 -0400
Date: Wed, 21 Jul 2004 10:52:08 -0400
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721145208.GA13522@kroah.com>
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407211626.55670.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 04:26:55PM +0200, Oliver Neukum wrote:
> Am Mittwoch, 21. Juli 2004 16:15 schrieb Greg KH:
> > Hm, seems kernel.org dropped my big patch, so the patch below can be
> > found at:
> > 	www.kernel.org/pub/linux/kernel/people/gregkh/misc/2.6/devfs-delete-2.6.8-rc2.patch
> 
> May I point out that 2.6 is supposed to be a _stable_ series?

You didn't pay attention to the first sentance that I wrote for the
patch :) 

And as Lars points out, the code is unmaintained, unused, and buggy.
All good reasons to rip out it out at any moment in time.

thanks,

greg k-h
