Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbTIFFsB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 01:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTIFFsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 01:48:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:59097 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262653AbTIFFsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 01:48:00 -0400
Date: Fri, 5 Sep 2003 22:32:50 -0700
From: Greg KH <greg@kroah.com>
To: John Wong <kernel@implode.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse lockup
Message-ID: <20030906053250.GA20034@kroah.com>
References: <20030905053549.GA480@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905053549.GA480@gambit.implode.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:35:49PM -0700, John Wong wrote:
> While in X, the mouse all of a sudden stopped working.  This is a usb
> mouse on 2.6.0-test4 on a nForce2 system.  Previously, when I had this
> problem on 2.4.21-x when the various nForce2 support was being worked
> on, my temp fix was to remove the ohci-usb module and reload.  I haven't
> run into problems in 2.4.22.  With 2.6.0-test4 however, when I try
> remove the usb module, I got this:

Can you enter this into a bug in bugzilla.kernel.org so it gets taken
care of?

thanks,

greg k-h
