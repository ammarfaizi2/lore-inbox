Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUJARbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUJARbg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUJARbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:31:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:53962 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265195AbUJARbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:31:33 -0400
Subject: Re: [patch] make dnotify compile-time configurable
From: Robert Love <rml@novell.com>
To: Matt Mackall <mpm@selenic.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
In-Reply-To: <20041001172735.GS31237@waste.org>
References: <1096611874.4803.18.camel@localhost>
	 <20041001151124.GQ31237@waste.org>
	 <1096644076.7676.6.camel@betsy.boston.ximian.com>
	 <20041001083110.76a58fd2.rddunlap@osdl.org>
	 <1096645479.7676.15.camel@betsy.boston.ximian.com>
	 <20041001085823.05adc9b5.rddunlap@osdl.org>
	 <1096650115.7676.20.camel@betsy.boston.ximian.com>
	 <20041001172735.GS31237@waste.org>
Content-Type: text/plain
Date: Fri, 01 Oct 2004 13:30:08 -0400
Message-Id: <1096651808.7676.28.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 12:27 -0500, Matt Mackall wrote:

> > In this case I offer A or A&B.
> 
> The configurable dnotify patch makes sense on its own and is perhaps
> less contentious. Push it first and resolve the conflicts with inotify
> later..

..the A above is dnotify by itself.  All I said--and I don't know why
anyone questioned it--is that I want to put dnotify's configurability in
the inotify patch.  They make sense together, and the patches conflict
anyways.  I can do this.

CONFIG_DNOTIFY makes sense either way, on its own or (more so) with
inotify, and I already posted the patch separately.

Why are we even talking about this?!?

	Robert Love


