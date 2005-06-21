Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVFUXD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVFUXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVFUXDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:03:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39049
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262459AbVFUW7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:59:54 -0400
Date: Tue, 21 Jun 2005 15:59:19 -0700 (PDT)
Message-Id: <20050621.155919.85409752.davem@davemloft.net>
To: gregkh@suse.de
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from
 being built
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050621222419.GA23896@kroah.com>
References: <20050621222419.GA23896@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Tue, 21 Jun 2005 15:24:19 -0700

> Here's a much smaller patch to simply disable devfs from the build.  If
> this goes well, and there are no complaints for a few weeks, I'll resend
> my big "devfs-die-die-die" series of patches that rip the whole thing
> out of the kernel tree.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

I know the rational behind this.

However, this does mean I do need to reinstall a couple
debian boxes here to something newer before I can continue
doing kernel work in 2.6.x on them.
