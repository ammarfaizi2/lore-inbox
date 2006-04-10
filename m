Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWDJJZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWDJJZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWDJJZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:25:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751088AbWDJJZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:25:17 -0400
Date: Mon, 10 Apr 2006 01:24:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: cmm@us.ibm.com, sho@tnes.nec.co.jp, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
 from 8TB to 16TB
Message-Id: <20060410012431.716d1000.akpm@osdl.org>
In-Reply-To: <1144660270.5816.3.camel@openx2.frec.bull.fr>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	<1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	<20060327131049.2c6a5413.akpm@osdl.org>
	<20060327225847.GC3756@localhost.localdomain>
	<1143530126.11560.6.camel@openx2.frec.bull.fr>
	<1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	<1143623605.5046.11.camel@openx2.frec.bull.fr>
	<1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	<20060329175446.67149f32.akpm@osdl.org>
	<1144660270.5816.3.camel@openx2.frec.bull.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Vivier <Laurent.Vivier@bull.net> wrote:
>
> Does the attached patch look like the thing you though about ?

I guess so.  But it'll need a lot of performance testing on big SMP
to work out what the impact is.
