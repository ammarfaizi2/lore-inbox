Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUJAR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUJAR1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJAR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:27:54 -0400
Received: from waste.org ([209.173.204.2]:34985 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265051AbUJAR1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:27:53 -0400
Date: Fri, 1 Oct 2004 12:27:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Robert Love <rml@novell.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
Subject: Re: [patch] make dnotify compile-time configurable
Message-ID: <20041001172735.GS31237@waste.org>
References: <1096611874.4803.18.camel@localhost> <20041001151124.GQ31237@waste.org> <1096644076.7676.6.camel@betsy.boston.ximian.com> <20041001083110.76a58fd2.rddunlap@osdl.org> <1096645479.7676.15.camel@betsy.boston.ximian.com> <20041001085823.05adc9b5.rddunlap@osdl.org> <1096650115.7676.20.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096650115.7676.20.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 01:01:55PM -0400, Robert Love wrote:
> On Fri, 2004-10-01 at 08:58 -0700, Randy.Dunlap wrote:
> 
> > Sorry, that's about all that I was trying to say.  If patches A & B
> > are logically separate, don't combine them.  Nothing new there.
> 
> In this case I offer A or A&B.

The configurable dnotify patch makes sense on its own and is perhaps
less contentious. Push it first and resolve the conflicts with inotify
later..

-- 
Mathematics is the supreme nostalgia of our time.
