Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274822AbTHIRLk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275065AbTHIRLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:11:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:60048 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274822AbTHIRLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:11:35 -0400
Date: Fri, 8 Aug 2003 22:57:40 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I2C errors
Message-ID: <20030809055739.GA6411@kroah.com>
References: <20030809025124.7ed1395e.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809025124.7ed1395e.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 02:51:24AM +0200, Udo A. Steinberg wrote:
> 
> Hi Greg,
> 
> Both under 2.4 and 2.5/2.6 I'm getting occasional I2C errors like these:
> 
> i2c-algo-bit.o: bt848 #0 i2c_write: error - bailout.
> msp34xx: I/O error #1 (read 0x12/0x18)
> 
> They repeat every 5 minutes or so until the video device (bttv) is
> reinitialized. 
> 
> Any ideas what's going on?

I don't know, sorry.  Try asking on the sensors mailing list.

Good luck,

greg k-h
