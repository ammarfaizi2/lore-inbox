Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbTHAVeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272431AbTHAVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:34:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:8663 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270831AbTHAVeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:34:17 -0400
Date: Fri, 1 Aug 2003 14:31:44 -0700
From: Greg KH <greg@kroah.com>
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [usb] Can't detect connected device w/ VT6206
Message-ID: <20030801213144.GC31881@kroah.com>
References: <20030801.045007.74743017.whatisthis@jcom.home.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801.045007.74743017.whatisthis@jcom.home.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 04:50:07AM +0900, Kyuma Ohta wrote:
> Hi,
> I'm using VIA KT400+ as mainboard,it includes VIA VT6206 as USB 2.0 I/F.
> When using kernel (2.4/2.6), this chip is probed as uhci or ehci,
> but connected device (i.e. gamepad,serial adapter) is not detected as
> right device.

What does the kernel log say when you plug in the usb device?

And what kernel version are you using?

thanks,

greg k-h
