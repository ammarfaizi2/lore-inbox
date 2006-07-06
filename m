Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWGFN50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWGFN50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGFN50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:57:26 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:61677 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030276AbWGFN5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:57:25 -0400
Date: Thu, 6 Jul 2006 15:57:17 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706155717.0ebbda32@cad-250-152.norway.atmel.com>
In-Reply-To: <20060706031416.33415696.akpm@osdl.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<20060706031416.33415696.akpm@osdl.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 03:14:16 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 6 Jul 2006 12:03:19 +0200
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > 
> > [stuff]
> >
> 
> OK, thanks.  Send me the whole lot when you think it's ready and
> we'll get it into the pipeline.  Not for 2.6.18 though - we need to
> give people time to look through it and send you nastygrams ;)

Great. I'll send you a patch when I get most/all the suggested changes
implemented.

> > > - How does one build a something->avr32 cross-toolchain?
> > 
> > I've started writing up a "Getting Started" guide at
> > http://avr32linux.org/twiki/bin/view/Main/GettingStarted. It's
> > mostly complete, although I haven't actually uploaded the toolchain
> > patches. I'll do that in a couple of minutes.
> 
> OK, well the more you can do there the better - that way crazy people
> cross-compile for your architecture and save you work.

I've uploaded patches for the basic stuff like binutils and gcc.
I've also updated the Getting Started page so that it should at least be
possible to build the kernel by following the instructions there.

So, all you crazy people should be able to start breaking stuff now ;)

Håvard
