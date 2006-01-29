Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWA2Xjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWA2Xjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWA2Xjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:39:43 -0500
Received: from xenotime.net ([66.160.160.81]:12254 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932084AbWA2Xjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:39:43 -0500
Date: Sun, 29 Jan 2006 15:40:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060129154002.360c7294.rdunlap@xenotime.net>
In-Reply-To: <20060129233403.GA3777@stusta.de>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060129233403.GA3777@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006 00:34:03 +0100 Adrian Bunk wrote:

> On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc1-mm3:
> >...
> > +i386-add-a-temporary-to-make-put_user-more-type-safe.patch
> > 
> >  x86 fixes/features
> >...
> 
> This patch generates so many "ISO C90 forbids mixed declarations and code"
> warnings that I start to consider Andrew's rejection of my "mark 
> virt_to_bus/bus_to_virt as __deprecated on i386" patch due to the 
> warnings it generates a personal insult...

I prefer to think of it as reasons why neither of them
should be merged.

---
~Randy
