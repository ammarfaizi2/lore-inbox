Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUCVT71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCVT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:59:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:9114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262368AbUCVT56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:57:58 -0500
Date: Mon, 22 Mar 2004 11:57:20 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Message-ID: <20040322195720.GA27480@kroah.com>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <20040320213030.GA3950@kroah.com> <20040320215219.GA20277@dreamland.darkstar.lan> <1079909446.911.165.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079909446.911.165.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 09:50:46AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I prefere graphics myself. Display sounds to generic. That is what video
> > and graphics output is piped to. Since fbdev doesn't handle video ouput
> > normally this is kind of fuzzy sounding.
> 
> I still prefer display...

Bah, I don't want to argue here.  I've applied Kronos's patch as is to
my device-2.6 tree which will end up in the next -mm release. 

I'll hold off forwarding this patch to Linus until after 2.6.5 is out,
so that gives everyone a few days in which to argue the name a bunch and
then send me a patch that changes it to the decided apon name (if it is
to be changed.)

thanks,

greg k-h
