Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTIHPmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTIHPlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:41:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29887 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263411AbTIHPkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:40:49 -0400
Date: Mon, 8 Sep 2003 08:39:54 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB fixes for 2.6.0-test4
Message-ID: <20030908083954.A13225@beaverton.ibm.com>
References: <20030906010405.GA18959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030906010405.GA18959@kroah.com>; from greg@kroah.com on Fri, Sep 05, 2003 at 06:04:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 06:04:05PM -0700, Greg KH wrote:
> Hi,
> 
> Here are some more USB fixes for 2.6.0-test4.  They include a fix for
> the uhci driver that a lot of people have been running into for a while.
> Also included is a fix for the pl2303 driver for B0 and for when you
> connect to the device after closing it.

> Duncan Sands:
>   o USB: fix uhci "host controller process error"

That patch fixed my problems with the UHCI driver (VIA) and 2.6.

Thanks!

-- Patrick Mansfield
