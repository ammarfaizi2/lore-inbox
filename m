Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270143AbTGPGAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270151AbTGPGAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:00:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:6370 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270143AbTGPGAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:00:03 -0400
Date: Tue, 15 Jul 2003 23:15:01 -0700
From: Greg KH <greg@kroah.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb in 2.4.22-pre6?
Message-ID: <20030716061501.GB5053@kroah.com>
References: <200307160102.07774.gene.heskett@verizon.net> <E19cedb-0004Mx-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19cedb-0004Mx-00@calista.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:15:35AM +0200, Bernd Eckenfels wrote:
> In article <200307160102.07774.gene.heskett@verizon.net> you wrote:
> > So my conclusion is that whatever has been adjusted in the usb stuffs, 
> > has now rendered the camera totally un-reachable.
> 
> have you started usbmgr or loaded the modules for chipset, hub and
> devicetype?

"usbmgr"?  I don't think that is even shipped by any distro anymore.

Try asking the authors of the driver for your device, as it lives
outside of the kernel tree, we can't do very much for you, sorry.

greg k-h
