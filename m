Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271000AbTGPRUC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTGPRSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:18:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:63165 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270966AbTGPRRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:17:43 -0400
Date: Wed, 16 Jul 2003 10:29:17 -0700
From: Greg KH <greg@kroah.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb in 2.4.22-pre6?
Message-ID: <20030716172916.GB8030@kroah.com>
References: <200307160102.07774.gene.heskett@verizon.net> <E19cedb-0004Mx-00@calista.inka.de> <20030716061501.GB5053@kroah.com> <20030716110622.GA27770@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716110622.GA27770@lina.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 01:06:22PM +0200, Bernd Eckenfels wrote:
> On Tue, Jul 15, 2003 at 11:15:01PM -0700, Greg KH wrote:
> > "usbmgr"?  I don't think that is even shipped by any distro anymore.
> 
> hmm.. i have it on my debian box and use it. it will configure the modules
> dpeending on the device and allows me to run scripts on plug. What is the
> new preffered way to do this?

Try using the hotplug package instead.

thanks,

greg k-h
