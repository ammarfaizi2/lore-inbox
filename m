Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130338AbRA3BC7>; Mon, 29 Jan 2001 20:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRA3BCt>; Mon, 29 Jan 2001 20:02:49 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:50201 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S130338AbRA3BCn>; Mon, 29 Jan 2001 20:02:43 -0500
Date: Mon, 29 Jan 2001 19:02:38 -0600
From: Matthew Fredrickson <lists@frednet.dyndns.org>
To: Adrian Cox <apc@agelectronics.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
Message-ID: <20010129190238.A15549@frednet.dyndns.org>
In-Reply-To: <3A75278F.B41B492B@bigfoot.com> <3A75507A.9386AFE2@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A75507A.9386AFE2@agelectronics.co.uk>; from apc@agelectronics.co.uk on Mon, Jan 29, 2001 at 11:14:02AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 11:14:02AM +0000, Adrian Cox wrote:
> Dylan Griffiths wrote:
> > The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
> > 2.4.0:
> > 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> > locks for a bit
> 
> This happens to me about once a month on a BX chipset PII machine here,
> and on a KT133 chipset machine I have.  I have to hit ctrl-alt-backspace
> to regain control of the console. I always assumed it was a bug in X,
> but it never caused me enough trouble to actually make me pursue it.

It happens to me also.  In fact, I posted a message a week or two ago
asking if anybody else had similar trouble and if anybody knew anything
about it.  I eventually just quit using the ps/2 mouse port and hooked my
mouse up to the usb port to get it fixed.  It irritated me a great deal
though until I finally just switched it over to usb.

Matthew Fredrickson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
