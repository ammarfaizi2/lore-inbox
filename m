Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSKRXpb>; Mon, 18 Nov 2002 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbSKRXpW>; Mon, 18 Nov 2002 18:45:22 -0500
Received: from dp.samba.org ([66.70.73.150]:14043 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267029AbSKRXpS>;
	Mon, 18 Nov 2002 18:45:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix compile error in usb-serial.c 
In-reply-to: Your message of "Mon, 18 Nov 2002 13:35:09 -0800."
             <20021118213508.GC13154@kroah.com> 
Date: Tue, 19 Nov 2002 10:26:40 +1100
Message-Id: <20021118235221.561DD2C3CC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021118213508.GC13154@kroah.com> you write:
> On Mon, Nov 18, 2002 at 03:39:09PM +0100, Adrian Bunk wrote:
> > drivers/usb/serial/usb-serial.c in 2.5.48 fails to compile with the
> > following error:
> 
> I don't get this error when building.  What does your .config look like?

No doubt CONFIG_MODULE=n.  His patch looks correct.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
