Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWAHBtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWAHBtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWAHBtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:49:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161130AbWAHBtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:49:02 -0500
Date: Sat, 7 Jan 2006 17:45:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] no longer mark MTD_OBSOLETE_CHIPS as BROKEN and
 remove broken MTD_OBSOLETE_CHIPS drivers
Message-Id: <20060107174523.460f1849.akpm@osdl.org>
In-Reply-To: <1136680734.30348.34.camel@pmac.infradead.org>
References: <20060107220702.GZ3774@stusta.de>
	<1136678409.30348.26.camel@pmac.infradead.org>
	<20060108002457.GE3774@stusta.de>
	<1136680734.30348.34.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> > > 2. What was the reason for marking them obsolete?
>  > 
>  > The changelog says:
>  >  - David Woodhouse: large MTD and JFFS[2] update
> 
>  I didn't ask who; I knew that. I asked you _why_. Admittedly, I happen
>  to know that too - but I want to know if _you_ know it.
> 
>  Since you've taken it upon yourself to decide the timescale of the
>  removal, surely it's reasonable to expect that you do actually know what
>  you're removing and why it's obsolescent?
>

Hey, Adrian isn't an MTD developer - give him a break.

What he's doing here is to poke other maintainers into getting the tree
cleaned up.  It's a useful thing to do.

If you, an MTD maintainer, can tell him what we _should_ be doing, I'm sure
Adrian would help.
