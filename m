Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTE3SOD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTE3SOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:14:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3507 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263867AbTE3SOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:14:03 -0400
Date: Fri, 30 May 2003 11:29:26 -0700
From: Greg KH <greg@kroah.com>
To: esp@pyroshells.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb problems with wireless device..
Message-ID: <20030530182926.GA19954@kroah.com>
References: <33268.65.122.196.250.1054315605.squirrel@mail.webhaste.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33268.65.122.196.250.1054315605.squirrel@mail.webhaste.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 10:26:45AM -0700, esp@pyroshells.com wrote:
> argh.. lets try this again..
> 
> I've got a wusb v2.1 wireless connection device, which I'm trying to use
> with linux 2.4.20-4GB (standard suse linux 8.2), and have been getting the
> following errors inside of dmesg:

I'd suggest asking the authors of the usbdfu driver, as that driver is
not included in the main kernel trees.

Good luck,

greg k-h
