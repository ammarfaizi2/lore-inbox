Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUHJOLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUHJOLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUHJOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:11:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:40427 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264919AbUHJOLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:11:50 -0400
Date: Mon, 9 Aug 2004 17:21:59 -0700
From: Greg KH <greg@kroah.com>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: dynamic /dev security hole?
Message-ID: <20040810002159.GE7131@kroah.com>
References: <1091969260.5759.125.camel@cube> <20040808175834.59758fc0.Ballarin.Marc@gmx.de> <20040808162115.GA7597@kroah.com> <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 12:07:27AM +0200, Marc Ballarin wrote:
> On Sun, 8 Aug 2004 09:21:15 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > Patches to the udev HOWTO and FAQ are always welcome.
> > 
> 
> How about this? The first part is a spelling fix.
> 
> (Resend, I hate "smart" features in software...)

Heh.  Thanks, I've applied this, and it will show up in the next udev
release.

greg k-h
