Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTJKC0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTJKC0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:26:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:54681 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263227AbTJKC0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:26:44 -0400
Date: Fri, 10 Oct 2003 19:26:28 -0700
From: Greg KH <greg@kroah.com>
To: Marc Chalain <marc-chalain@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sitecom (R)  USB-DOCK serial converter driver
Message-ID: <20031011022628.GD19749@kroah.com>
References: <3F867398.4050306@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F867398.4050306@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 10:53:44AM +0200, Marc Chalain wrote:
> Hello every body
> I bought a USB-DOCK of Sitecom(R) connectivty. The linux standard usb 
> driver support the parallel printer driver, the 2 ps2 connectors and the 
> USB-Hub. But the serial converter is not compatible with the linux 
> generic USB-Serial driver.
> I build a usb-serial driver from the source of the generic usb-serial 
> driver, and it seems to work.
> Now i'm looking for somebody to try this driver. Can somebody help me?
> I created a patch for the kernel 2.4.22.

Please send it to the linux-usb-devel mailing list.

thanks,

greg k-h
