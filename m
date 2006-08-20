Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWHTIDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWHTIDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHTIDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:03:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbWHTIDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:03:18 -0400
Date: Sun, 20 Aug 2006 01:03:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-Id: <20060820010311.6d953c3b.akpm@osdl.org>
In-Reply-To: <20060820074401.GA14732@amd64.of.nowhere>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<20060820074401.GA14732@amd64.of.nowhere>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 09:44:01 +0200
thunder7@xs4all.nl wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Sat, Aug 19, 2006 at 10:00:08PM -0700
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> > 
> > 
> > - Various random stuff.
> > 
> > - I haven't been pulling Greg's post-2.6.18-rc4 tree due to various git woes
> >   which I haven't gotten around to working out how to fix.  But most of it
> >   will be here anyway.
> > 
> > - The automounter is known to be a bit broken.
> > 
> > - Alpha coredumps won't work right.
> > 
> Also, it stil has the funny fast moving clock on x86-64

yup, that's the NTP changes.  Sorry, I should have mentioned that.
I'm hanging onto the patches in the expectation/hope that Roman
will be able to fix them soon.
