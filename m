Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTLRO4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbTLRO4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:56:43 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:28564 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265206AbTLRO4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:56:40 -0500
Date: Thu, 18 Dec 2003 09:54:34 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 keyboard not working
Message-ID: <20031218145434.GA20303@gnu.org>
References: <20031218060053.GA645@gnu.org> <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 02:31:09AM -0500, Zwane Mwaikambo wrote:

> > Hi,
> >
> > Halfway between having uncompressed the kernel and starting init, the console
> > starts to scroll "atkbd.c: Unknown key pressed", mentioning key code 0 (IIRC),
> > even though no keys are pressed at all.  After a while, the scrolling stops,
> > but the keyboard still doesn't work.  2.4 works fine on the same hardware.
> >
> > Hardware is an Intel SE7505VB2 board with dual 2.40GHz Xeon processors,
> > and a Logitech PS/2 "Internet keyboard."
> >
> > Ideas?
> 
> May we have a look at your .config?

It's attached in .gz format (sorry, it wouldn't go through otherwise :/).


--L
