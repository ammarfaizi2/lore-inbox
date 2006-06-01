Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWFAJ2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWFAJ2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFAJ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:28:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:22416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750782AbWFAJ17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:27:59 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc5-mm2
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 11:30:33 +0200
Message-Id: <1149154233.12777.14.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 01:48 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> 
> 
> - A cfq bug was fixed in mainline, so the git-cfq tree has been restored.

I put the fix for slab corruption into mm1, and it did indeed cure that.
However, if I add git-cfq.patch, my box still explodes.

	-Mike

