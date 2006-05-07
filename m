Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWEGAV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWEGAV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 20:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWEGAV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 20:21:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27853
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751146AbWEGAV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 20:21:56 -0400
Date: Sat, 06 May 2006 17:21:58 -0700 (PDT)
Message-Id: <20060506.172158.39305190.davem@davemloft.net>
To: greg@kroah.com
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netdev: create attribute_groups with
 class_device_add
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060506225904.GA17704@kroah.com>
References: <20060506040839.GA12636@kroah.com>
	<20060505.230050.56609951.davem@davemloft.net>
	<20060506225904.GA17704@kroah.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Sat, 6 May 2006 15:59:04 -0700

> On Fri, May 05, 2006 at 11:00:50PM -0700, David S. Miller wrote:
> > The networking bit by Stephen is a bug fix.
> 
> Good point.  Ok, feel free to send both patches to Linus now if you
> want.  You can add my:
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> to the driver core change as I have no problems with it.
> Or I can send them on Monday if you wish.  Whatever is easier for you.

I'll take care of pushing the changes, thanks Greg.
