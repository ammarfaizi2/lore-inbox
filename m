Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280289AbRK1TRW>; Wed, 28 Nov 2001 14:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280251AbRK1TRC>; Wed, 28 Nov 2001 14:17:02 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:65290 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280037AbRK1TPF>; Wed, 28 Nov 2001 14:15:05 -0500
Date: Wed, 28 Nov 2001 15:57:56 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS driver -- Can it go in?
In-Reply-To: <1006973117.11751.15.camel@thanatos>
Message-ID: <Pine.LNX.4.21.0111281557290.15571-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 Nov 2001, Thomas Hood wrote:

> On Wed, 2001-11-28 at 11:10, Alan Cox wrote:
> > Submit it to Linus.
> 
> Linus and Marcelo: Would either of you accept a patch to add
> the pnpbios driver with /proc interface, so we can use lspnp
> and setpnp to control how PnP BIOS configures devices?
> 
> This driver was in 2.4.x-acy for quite a long time and I
> believe that the basic functionality was pretty well
> debugged and tested.

Initially yes... it all depends on the state of the driver of course.

