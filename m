Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUCSWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUCSWP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:15:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:9386 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261821AbUCSWP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:15:26 -0500
Date: Fri, 19 Mar 2004 14:10:55 -0800
From: Greg KH <greg@kroah.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 UHCI HCD BUG
Message-ID: <20040319221055.GA14128@kroah.com>
References: <20040319184640.GA1938@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319184640.GA1938@mail.muni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 07:46:40PM +0100, Lukas Hejtmanek wrote:
> Hello,
> 
> with 2.6.4 if I do rmmod uhci_hcd and then modprobe uhci_hcd while running
> X server with USB mouse connected to UHCI USB I got:

Try sending this to the linux-usb-devel mailing list and CC the uhci
driver maintainer.

thanks,

greg k-h
