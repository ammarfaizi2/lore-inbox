Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbUBBXXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUBBXXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:23:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:5333 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265866AbUBBXXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:23:42 -0500
Date: Mon, 2 Feb 2004 15:11:06 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040202231106.GB1494@kroah.com>
References: <20040126215036.GA6906@kroah.com> <401ED872.40609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401ED872.40609@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 12:08:34AM +0100, Prakash K. Cheemplavam wrote:
> Hi,
> 
> I wonder why your framebuffer patch didn't make it into mm-kernel? Was 
> something wrong about it? I applied it and then bootsplash doesn't 
> complain about missing /dev/fb0...

I didn't ask for it to go into the -mm kernel :)

I thought the framebuffer update was going to make it into there, but I
guess it never did.  I guess I can dig it out of my tree and send it to
Andrew in a few days.

thanks,

greg k-h
