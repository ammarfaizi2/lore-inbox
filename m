Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbTLKUWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLKUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:22:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4225 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265222AbTLKUWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:22:09 -0500
Date: Thu, 11 Dec 2003 15:25:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: Where did the ELF spec go?  (SCO website?)
In-Reply-To: <20031211194430.GL8039@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0312111523330.6378@chaos>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
 <20031211094148.G28449@links.magenta.com> <20031211150011.GF8039@holomorphy.com>
 <200312111326.32483.rob@landley.net> <20031211194430.GL8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, William Lee Irwin III wrote:

> On Thursday 11 December 2003 09:00, William Lee Irwin III wrote:
> >> You have it backward. The SVR4/i386 ELF ABI specification is requiring
> >> userspace to be granted at least 3GB of address space.
>
> On Thu, Dec 11, 2003 at 01:26:32PM -0600, Rob Landley wrote:
> > Where does one get a copy of the SVR4 spec these days?  The link I
> > could track down went to http://www.sco.com/developer/devspecs/ which
> > just ain't there no more.
> > And no, not because of a "DDOS".  There isn't one.  SCO's website IP moved
> > from 216.250.128.13 to 216.250.128.20, and it's up at the new IP right now.
> > They didn't get the new DNS record propogated on time.  Rookie mistake...
> > But looking at http.://216.250.128.20/developer/devspecs redirects
> > you to the /developer page.  The devspecs page went away...
> > Is this mirrored somewhere?
>
> I'm looking at a dead tree copy. I have no idea if it's online or not.
>
> Also, it's largely an ELF ABI spec; I'm not sure how/why SVR4 got into
> the picture, but its name is on there.


http://developers.sun.com/solaris/articles/elf.html


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


