Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUIYD42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUIYD42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269222AbUIYD41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:56:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:56967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269221AbUIYD40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:56:26 -0400
Date: Fri, 24 Sep 2004 20:55:59 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK] Changing driver core/sysfs/kobject symbol exports to GPL only
Message-ID: <20040925035559.GA13804@kroah.com>
References: <Pine.LNX.4.50.0409241202110.30766-200000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0409241202110.30766-200000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:42:31PM -0700, Patrick Mochel wrote:
> 
> What's life without a little controversey once in a while?

Boring :)

> Many of those subsystems cannot be built modularly [2].

Hey, some of them can.  Like i2c and usb for example.  And one of these
days we'll get pci modular just because it's a fun thing to attempt.

> So, my question is - does this make sense to others?

Yes, I completely agree with this change.

> Are there are any technical reasons for not doing this?

Nope.

> If not, then please apply/pull.

I will do so in a few minutes, thanks for the patches.

greg k-h
