Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbSKOWr4>; Fri, 15 Nov 2002 17:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbSKOWr4>; Fri, 15 Nov 2002 17:47:56 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:9681 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S266908AbSKOWrz>; Fri, 15 Nov 2002 17:47:55 -0500
Date: Fri, 15 Nov 2002 23:53:43 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Dmitri <dmitri@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021115225343.GB1877@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Dmitri <dmitri@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <1037400456.1565.38.camel@usb.networkfab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037400456.1565.38.camel@usb.networkfab.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:47:35PM -0800, Dmitri wrote:

> > Using USB instead of the serial line or the network card would be
> > the best IMHO, because:
[...]
> 
> USB hardware and protocols are master-slave, meaning that you can not
> connect another computer to this one directly. 

Of course, you are correct :(

> What USB *device* would
> you want to see connected?

Well, I could say 'iPAQ' here but I guess it's getting out of
topic.
 
> Of course, a USB-Serial adapter would work, and you can connect any
> serial terminal, but then we are back to using serial ports; it's just
> you will need a different driver for that.

Well, I have one of those, and it could be a good replacement because
it needs serial only on the development box, not on the target. It
would be acceptable for me in any case (because I already have the
adapter), but it probably won't be in the general case, given the
price ratio between a network card and the USB-Serial adapter.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
