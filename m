Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWFMCb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWFMCb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 22:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbWFMCbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 22:31:25 -0400
Received: from proof.pobox.com ([207.106.133.28]:8106 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932784AbWFMCbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 22:31:25 -0400
Date: Mon, 12 Jun 2006 19:31:19 -0700
From: Paul Dickson <paul@permanentmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
Message-Id: <20060612193119.e0ff94d8.paul@permanentmail.com>
In-Reply-To: <Pine.LNX.4.64.0606100257550.17704@scrub.home>
References: <44869397.4000907@tls.msk.ru>
	<Pine.LNX.4.64.0606080036250.17704@scrub.home>
	<e69fu3$5ch$1@terminus.zytor.com>
	<Pine.LNX.4.64.0606091409220.17704@scrub.home>
	<e6cgjv$b8t$1@terminus.zytor.com>
	<Pine.LNX.4.64.0606100257550.17704@scrub.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 03:15:59 +0200 (CEST), Roman Zippel wrote:

> On Fri, 9 Jun 2006, H. Peter Anvin wrote:
> 
> > > If you wouldn't remove all old init code at once it would still be 
> > > possible to build a kernel this way. Why are you making it mandatory? Why 
> > > don't you leave it optional for a while and only gradually remove the old 
> > > code? This way distributions/users can experiment with it regarding their 
> > > current initrd/boot setups.
> > 
> > Linus vetoed that option years ago.
> 
> Name dropping is of course always impressive - scares little kids and all.
> Could you please provide more info, what exactly he vetoed?

His rule was no code was to be added to the kernel code unless it already
had a user.  So there would be no adding code hoping a user would appear.

If I'm wrong, I'll likely be corrected... :-)

	-Paul

