Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUDLXsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 19:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUDLXsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 19:48:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:7353 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263173AbUDLXsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 19:48:15 -0400
Date: Mon, 12 Apr 2004 16:36:32 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New ID for ftdi_sio
Message-ID: <20040412233632.GA27334@kroah.com>
References: <20040408165123.GA11376@dreamland.darkstar.lan> <20040409191450.GB17546@kroah.com> <20040410154107.GA3983@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410154107.GA3983@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 05:41:07PM +0200, Kronos wrote:
> Il Fri, Apr 09, 2004 at 12:14:50PM -0700, Greg KH ha scritto: 
> > On Thu, Apr 08, 2004 at 06:51:23PM +0200, Kronos wrote:
> > > Hi,
> > > I have an USB contactless reader which uses a FTDI chip. It works well with the
> > > current ftdi_sio driver, it's just a matter of adding an ID:
> > 
> > Ick, this patch doesn't apply due to all of the recent ids being added
> > to this driver.  Can you re-diff it against the latest -mm tree and
> > resend it to me?
> 
> Here it is:

Looks good, thanks.  I've applied this to my trees and will send it off
in the next round of updates.

greg k-h
