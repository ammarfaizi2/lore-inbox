Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVIPV5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVIPV5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVIPV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:38285 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750706AbVIPV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:26 -0400
Date: Fri, 16 Sep 2005 14:49:16 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916214916.GB13920@suse.de>
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org> <200509152023.44003.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509152023.44003.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:23:43PM -0500, Dmitry Torokhov wrote:
> On Thursday 15 September 2005 20:04, Kay Sievers wrote:
> > I like that the child devices are actually below the parent device
> > and represent the logical structure. I prefer that compared to the
> > symlink-representation between the classes at the same directory
> > level which the input patches propose.
> 
> Why don't we take it a step further and abandon classes altogether?

Not going to happen, sorry :)

greg k-h
