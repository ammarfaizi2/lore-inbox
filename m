Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbULQBCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbULQBCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbULQBCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:02:53 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:19634 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262696AbULQAzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:55:12 -0500
Date: Fri, 17 Dec 2004 01:51:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
In-Reply-To: <1103244171.13614.2525.camel@localhost>
Message-ID: <Pine.LNX.4.61.0412170150080.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com> 
 <Pine.LNX.4.61.0412170133560.793@scrub.home> <1103244171.13614.2525.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Dec 2004, Dave Hansen wrote:

> > Why do you want to move struct page into a separate file?
> 
> Circular header dependencies suck :)

Could you explain a bit more, what exactly the problem is?

bye, Roman
