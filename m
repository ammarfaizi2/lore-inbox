Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275524AbTHNVQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 17:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275528AbTHNVQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 17:16:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:56248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275524AbTHNVQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 17:16:27 -0400
Date: Thu, 14 Aug 2003 14:14:02 -0700
From: Greg KH <greg@kroah.com>
To: Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-ID: <20030814211402.GA3640@kroah.com>
References: <20030802052904.GA9782@kroah.com> <20030802095518.4c5630ef.khali@linux-fr.org> <20030802165638.GF11038@kroah.com> <20030803052728.GC5202@earth.solarsys.private> <20030804160630.GB3395@kroah.com> <20030805034921.GB11605@earth.solarsys.private> <20030814051347.GB15093@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814051347.GB15093@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 01:13:47AM -0400, Mark M. Hoffman wrote:
> This is a resend of a patch to the i2c-nforce2.c I2C bus driver.
> The start of the relevant thread was here:
> http://archives.andrew.net.au/lm-sensors/msg03820.html
> 
> [comment]
> This patch restores a line that was wrongly removed.  There are also some
> trivial cleanups.  It applies & compiles vs. 2.6.0-test3.  It's untested
> (no hardware here).
> [/comment]

Oops, sorry I forgot this one.  I've now applied it and will send it on
later to Linus.

greg k-h
