Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWGJJig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGJJig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGJJif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:38:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964867AbWGJJif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:38:35 -0400
Date: Mon, 10 Jul 2006 02:37:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       dwmw2@infradead.org, tglx@linutronix.de, arjan@infradead.org,
       rmk+lkml@arm.linux.org.uk
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-Id: <20060710023758.986a91e9.akpm@osdl.org>
In-Reply-To: <20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<20060706031416.33415696.akpm@osdl.org>
	<20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 11:03:25 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> I've put up an updated patch at
> http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-3.patch

That diff doesn't update ./MAINTAINERS

Please prepare a nice changelog describing the architecture (what's an
avr?), who supports it, useful web pages, how to build cross-tools, etc. 
The sort of things which Linus and kernel developers should know when
someone sends in a half-megabyte patch.

And a signed-off-by:, as per section 11 of Documentation/SubmittingPatches.

Thanks.
