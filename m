Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUJARhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUJARhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUJARhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:37:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:51430 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265161AbUJARhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:37:09 -0400
Date: Fri, 1 Oct 2004 10:30:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Love <rml@novell.com>
Cc: mpm@selenic.com, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
Subject: Re: [patch] make dnotify compile-time configurable
Message-Id: <20041001103021.575d6d48.rddunlap@osdl.org>
In-Reply-To: <1096651808.7676.28.camel@betsy.boston.ximian.com>
References: <1096611874.4803.18.camel@localhost>
	<20041001151124.GQ31237@waste.org>
	<1096644076.7676.6.camel@betsy.boston.ximian.com>
	<20041001083110.76a58fd2.rddunlap@osdl.org>
	<1096645479.7676.15.camel@betsy.boston.ximian.com>
	<20041001085823.05adc9b5.rddunlap@osdl.org>
	<1096650115.7676.20.camel@betsy.boston.ximian.com>
	<20041001172735.GS31237@waste.org>
	<1096651808.7676.28.camel@betsy.boston.ximian.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 13:30:08 -0400 Robert Love wrote:

| On Fri, 2004-10-01 at 12:27 -0500, Matt Mackall wrote:
| 
| > > In this case I offer A or A&B.
| > 
| > The configurable dnotify patch makes sense on its own and is perhaps
| > less contentious. Push it first and resolve the conflicts with inotify
| > later..
| 
| ..the A above is dnotify by itself.  All I said--and I don't know why
| anyone questioned it--is that I want to put dnotify's configurability in
| the inotify patch.  They make sense together, and the patches conflict
| anyways.  I can do this.

You can do that.  Go ahead.
Even if it isn't clear that they make sense together.
Lots of patches conflict, but that's no grand reason to combine them.

| CONFIG_DNOTIFY makes sense either way, on its own or (more so) with
| inotify, and I already posted the patch separately.
| 
| Why are we even talking about this?!?

I'm going quiet on it...


-- 
~Randy
