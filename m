Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbTD1SkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbTD1SkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:40:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:49847 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261237AbTD1SkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:40:17 -0400
Date: Mon, 28 Apr 2003 11:54:35 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Tscharner <starfire@dplanet.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: USB mouse with EHCI module
Message-ID: <20030428185435.GA25264@kroah.com>
References: <20030428203611.1307000b.starfire@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428203611.1307000b.starfire@dplanet.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 08:36:11PM +0200, Andreas Tscharner wrote:
> Hello World,
> 
> My new USB mouse (Logitech MouseMan Traveler) does not work correctly
> with the EHCI module. The button in the middle (the scroll wheel
> actually) does not work with EHCI while it does with UHCI.
> 
> Kernel 2.4.20 on a Debian GNU/Linux

Does it work ok on 2.5?
And how about 2.4.21-rc1?  The EHCI code is much better there than
2.4.20.

thanks,

greg k-h
