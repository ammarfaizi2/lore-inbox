Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUDITPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUDITPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:15:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:7109 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261654AbUDITPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:15:31 -0400
Date: Fri, 9 Apr 2004 12:14:50 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New ID for ftdi_sio
Message-ID: <20040409191450.GB17546@kroah.com>
References: <20040408165123.GA11376@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408165123.GA11376@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 06:51:23PM +0200, Kronos wrote:
> Hi,
> I have an USB contactless reader which uses a FTDI chip. It works well with the
> current ftdi_sio driver, it's just a matter of adding an ID:

Ick, this patch doesn't apply due to all of the recent ids being added
to this driver.  Can you re-diff it against the latest -mm tree and
resend it to me?

thanks,

greg k-h
