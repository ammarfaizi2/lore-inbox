Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUIWRVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUIWRVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIWRVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:21:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37603 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268200AbUIWRQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:16:27 -0400
Subject: Re: [PATCH] mark inter_module_* deprecated
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99704092218531ec19260@mail.gmail.com>
References: <20040919101337.GA5910@lst.de>
	 <21d7e99704092218531ec19260@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095956022.6735.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Sep 2004 17:13:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-23 at 02:53, Dave Airlie wrote:
> Most of this stuff is easier if we weren't waiting on Alans vga class
> support driver to turn up as without it the DRM CVS is blocked, and no
> DRM developer really wants to start hacking on the vga class stuff as
> we don't believe it is where our time is best spent until Alan gets
> code merged into the kernel and gets the fb guys to convert all their
> drivers... I've already got a patch for converting the DRM to a fixed
> up version of his last patch...

If you've got it working and everyone is happy just submit it. It looks
like I'm going to be tty driver hacking for some time yet and you've
already done the hardest bit - debugging it.

