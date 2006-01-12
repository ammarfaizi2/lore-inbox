Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWALR01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWALR01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWALR00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:26:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932355AbWALR0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:26:25 -0500
Date: Thu, 12 Jan 2006 17:26:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.org
Subject: Re: need for packed attribute
Message-ID: <20060112172617.GC9288@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, oliver@neukum.org
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se> <20060112092006.6a9f4509.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112092006.6a9f4509.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 09:20:06AM -0800, Pete Zaitcev wrote:
> P.S. I am repeating myself as Katon, but I am yet to see why any of
> this matters. Neither Russell nor Oliver ever presented a case where
> an unpacked struct caused breakage in USB.

If you would like to refresh your memory (which is obviously faulty)
you'll see that my involvement in this thread was merely to answer
a simple question about structure sizes.

It was not a bug report about USB breaking.  Therefore, I have no
case to present.

(And WTF do soo many people assume that I'm somehow always reporting
a bloody bug and have to present such cases when I get copied on
emails to answer questions?  I don't understand the stupid mentality
there - this is _not_ the first time this has happened in the 12 days
of 2006 so far.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
