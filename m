Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVKJIkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVKJIkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVKJIkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:40:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17232 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750885AbVKJIky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:40:54 -0500
Date: Thu, 10 Nov 2005 09:41:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
Message-ID: <20051110084136.GX3699@suse.de>
References: <20051109133558.513facef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109133558.513facef.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09 2005, Andrew Morton wrote:
> -rw-r--r--    1 akpm     akpm        21829 Nov  9 11:19 git-blktrace.patch

This one can wait for the next release, so if it's ok with you I'll just
let it simmer in -mm some more. I do make sure that the blktrace branch
of the git tree is uptodate so the amount of hassle should be low for
you.

-- 
Jens Axboe

