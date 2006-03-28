Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWC1AHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWC1AHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWC1AHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:07:24 -0500
Received: from xenotime.net ([66.160.160.81]:35998 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932128AbWC1AHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:07:23 -0500
Date: Mon, 27 Mar 2006 16:09:39 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: sam@ravnborg.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: smp_locks reference_discarded errors
Message-Id: <20060327160939.40475581.rdunlap@xenotime.net>
In-Reply-To: <20060328000418.GB19025@redhat.com>
References: <20060325033948.GA15564@redhat.com>
	<20060325235035.5fcb902f.akpm@osdl.org>
	<20060326154042.GB13684@redhat.com>
	<20060326161055.GA4584@mars.ravnborg.org>
	<20060328000418.GB19025@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006 19:04:18 -0500 Dave Jones wrote:

> On Sun, Mar 26, 2006 at 06:10:55PM +0200, Sam Ravnborg wrote:
> 
>  > Also the output from modpost provides a bit more info.
>  > So output from fresh -linus kernel would make it easier to locate the
>  > guilty stuff.
> 
> Finally coaxed latest -git to build on all archs I care about..
> grab http://people.redhat.com/davej/buildlog.txt  and grep for WARNING:
> and see a zillion errors.  The smp_locks ones seem to have disappeared
> now though.

I just posted a boatload of them to the kernel-janitors m-l also.

---
~Randy
