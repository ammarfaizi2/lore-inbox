Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUAYXAj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUAYXAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:00:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:60126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265317AbUAYXAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:00:34 -0500
Date: Sun, 25 Jan 2004 14:59:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: ak@muc.de, cova@ferrara.linux.it, bunk@fs.tum.de, eric@cisu.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040125145948.581d753c.akpm@osdl.org>
In-Reply-To: <20040125223105.GE28576@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401252221.01679.cova@ferrara.linux.it>
	<20040125214653.GB28576@colin2.muc.de>
	<200401252308.33005.cova@ferrara.linux.it>
	<20040125221304.GD28576@colin2.muc.de>
	<20040125142500.526dcac5.akpm@osdl.org>
	<20040125223105.GE28576@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Sun, Jan 25, 2004 at 02:25:00PM -0800, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > I would suspect the new weird CPU
> > >  configuration stuff.
> > 
> > What do you believe is wrong with it?
> 
> It's different and it is weird and probably easy to screw up.
> 

I must say that it does seem to be causing quite a few problems and doesn't
have a very good benefit:breakage ratio.  Maybe we should say that 2.6 has
sucky CPU selection and leave it for 2.7.  

