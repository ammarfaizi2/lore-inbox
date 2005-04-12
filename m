Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVDLH1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVDLH1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVDLH1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:27:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:36750 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261913AbVDLH1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:27:16 -0400
Date: Tue, 12 Apr 2005 00:08:45 -0700
From: Greg KH <greg@kroah.com>
To: Melanie Dumas <melanie.dumas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usbdux registers, but communcation to device times out
Message-ID: <20050412070845.GA1064@kroah.com>
References: <811ff18e05040814223c0b4a1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811ff18e05040814223c0b4a1b@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 02:22:52PM -0700, Melanie Dumas wrote:
> 
> We installed comedi and comedilib according to the instructions on
> http://www.linux-usb-daq.co.uk/drivers2/2.6/. There were no errors on
> installation, and the usbdux drivers were auto-detected by hotplug
> when the usbdux controller was plugged in. We saw the message "kernel:
> comedi0: usbdux: usb-device 0 is attached to comedi."

Why not ask the authors of that driver, as we do not know anything about
what is in that code (hint, odds are it's due to a usb api change...)

Good luck,

greg k-h
