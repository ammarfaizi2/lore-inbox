Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTLGIB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 03:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTLGIB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 03:01:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:35490 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263765AbTLGIBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 03:01:55 -0500
Date: Sat, 6 Dec 2003 23:32:26 -0800
From: Greg KH <greg@kroah.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB/visor oops
Message-ID: <20031207073226.GA29569@kroah.com>
References: <1070778430.25972.3.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070778430.25972.3.camel@mentor.gurulabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 11:27:10PM -0700, Dax Kelson wrote:
> After having had my Tre600 hotsyncing working fine with RHL9 I'm trying
> again after upgrading to Fedora. So far all I get are oops and hangs.
> 
> This is with the Fedora kernel 2.4.22-1.2115.nptl. This is with the uhci
> instead of usb-uhci.

Can you try 2.4.23?  This problem should be fixed there.

thanks,

greg k-h
