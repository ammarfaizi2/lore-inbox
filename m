Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbTGOVTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbTGOVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:19:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:47072 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269744AbTGOVTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:19:31 -0400
Date: Tue, 15 Jul 2003 14:29:56 -0700
From: Greg KH <greg@kroah.com>
To: crozierm@consumption.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse "hang" with 2.5.75
Message-ID: <20030715212956.GA5524@kroah.com>
References: <20030715211245.GA5435@kroah.com> <Pine.LNX.4.21.0307151418520.7513-100000@consumption.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0307151418520.7513-100000@consumption.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 02:28:07PM -0700, crozierm@consumption.net wrote:
> 
> > Does the same thing happen on 2.4.21?
> 
> Nope, never.
> 
> > Can you enable CONFIG_USB_DEBUG?
> 
> It already is enabled.  When this happens, nothing is printed in the logs
> until I unplug the mouse.
> 
> > Hm, yeah, this looks like an X issue :)
> 
> Should it be possible for X to lock up the mouse?  When the mouse stops
> working in X, it seems to stop working for everything else too (the "cat
> /dev/input/mice" test, at least).

Hm, don't really know, sorry.

greg k-h
