Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTLSSVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTLSSVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:21:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28125 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262321AbTLSSVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:21:32 -0500
Date: Fri, 19 Dec 2003 19:21:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Molina <tmolina@cablespeed.com>, smiler@lanil.mine.nu,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-mm1
Message-ID: <20031219182121.GF2069@suse.de>
References: <20031217014350.028460b2.akpm@osdl.org> <200312171037.16969.andrew@walrond.org> <3FE039F5.5030703@lanil.mine.nu> <20031217035105.3c0bd533.akpm@osdl.org> <Pine.LNX.4.58.0312172220060.2348@localhost.localdomain> <20031217193600.1139f7c0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217193600.1139f7c0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17 2003, Andrew Morton wrote:
> >  I'm going to do my part by pounding heavily on -mm kernels since that 
> >  appears where all this is ending up.
> 
> That would be useful.  Testing on non-ia32 platforms remains a concern.  I
> test on ia64 and ppc64, but I'm not aware of anyone regularly testing -mm
> things on other architectures.

I've tested regularly on x86_64 (which I think is more important than
both ia64 (who cares) and ppc64). I'll start doing that again.

-- 
Jens Axboe

