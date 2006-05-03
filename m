Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWECTKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWECTKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWECTKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:10:42 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:35231 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750719AbWECTKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:10:42 -0400
From: David Brownell <david-b@pacbell.net>
To: David Hollis <dhollis@davehollis.com>
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Wed, 3 May 2006 12:10:34 -0700
User-Agent: KMail/1.7.1
Cc: Michael Helmling <supermihi@web.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <200605031528.18809.supermihi@web.de> <1146667488.2348.28.camel@dhollis-lnx.sunera.com>
In-Reply-To: <1146667488.2348.28.camel@dhollis-lnx.sunera.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605031210.35865.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 7:44 am, David Hollis wrote:
> Correct.  He is violating the license in a number of ways, though it
> probably isn't totally intentional.

Removing copyright and licence statements can't have been anything BUT
intentional.

That's really a basic rule, pretty much a "programming 101" thing.  You
know, like "test your code", "don't remove other folks' copyrights",
"don't try to change the licence on code copyrighted by someone else".


> The development on that driver 
> probably began before usbnet was modularized to allow for the
> componentizing of driver specific code outside of usbnet.

Well, it's always allowed driver modularization ... the change was only
to move the hardware-specific parts outside of the driver core.


I certainly could see how work on this Moschip support might have
started before September of last year, when the core was more fully
split out.  But that's still no excuse for this kind of "piracy".

- Dave
