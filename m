Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUFKSDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUFKSDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFKSDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 14:03:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:59291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264302AbUFKSCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 14:02:00 -0400
Date: Fri, 11 Jun 2004 10:59:47 -0700
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, rtjohnso@eecs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040611175946.GA16673@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com> <20040611192116.1bb87553.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611192116.1bb87553.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 07:21:16PM +0200, Jean Delvare wrote:
> > And to be complete, here's a patch to clean up the warnings in the
> > drivers/i2c tree.  I've also applied it to my trees.
> > (...)
> > # I2C: sparse cleanups for drivers/i2c/*
> 
> Should any of these be backported to i2c in 2.4?

Nah, it's not worth it.

thanks,

greg k-h
