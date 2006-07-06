Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWGFKOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWGFKOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWGFKOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:14:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965183AbWGFKOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:14:22 -0400
Date: Thu, 6 Jul 2006 03:14:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-Id: <20060706031416.33415696.akpm@osdl.org>
In-Reply-To: <20060706120319.26b35798@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 12:03:19 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> 
> [stuff]
>

OK, thanks.  Send me the whole lot when you think it's ready and we'll get
it into the pipeline.  Not for 2.6.18 though - we need to give people time
to look through it and send you nastygrams ;)

> > - How does one build a something->avr32 cross-toolchain?
> 
> I've started writing up a "Getting Started" guide at
> http://avr32linux.org/twiki/bin/view/Main/GettingStarted. It's mostly
> complete, although I haven't actually uploaded the toolchain patches.
> I'll do that in a couple of minutes.

OK, well the more you can do there the better - that way crazy people
cross-compile for your architecture and save you work.

