Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUJOTtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUJOTtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUJOTti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:49:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:46313 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268392AbUJOTth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:49:37 -0400
Date: Fri, 15 Oct 2004 21:49:36 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: ak@suse.de, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] x86_64/io_apic init section fixups
Message-ID: <20041015194936.GA31195@wotan.suse.de>
References: <416F6166.7010207@osdl.org> <4170158B.6020802@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4170158B.6020802@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:23:07AM -0700, Randy.Dunlap wrote:
> Randy.Dunlap wrote:
> >
> >scripts/reference_init.pl found a couple of errors in i386/io_apic.c.
> >When changing them, one more function had to be un-init-ed.
> >
> >I should check x86_64 also ... tomorrow.
> 
> Here's the x86_64 version of this patch.

Thanks Randy. I added it to my tree.

-Andi
