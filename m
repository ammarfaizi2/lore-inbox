Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVGaXup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVGaXup (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVGaXul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262131AbVGaXuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:50:37 -0400
Date: Sun, 31 Jul 2005 16:50:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] net driver fixes
In-Reply-To: <42ED5F30.2080907@pobox.com>
Message-ID: <Pine.LNX.4.58.0507311649460.14342@g5.osdl.org>
References: <42ED5F30.2080907@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Jeff Garzik wrote:
>
> Please pull from the 'upstream-fixes' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 
> to obtain the fixes described in the attached diffstat/changelog/patch.

Could you please try to edit the emails you apply to something prettier 
than this:


    [PATCH] Fix OMAP specific typo in smc91x.h

    --ReaqsoxgOBHFXBhH
    Content-Type: text/plain; charset=us-ascii
    Content-Disposition: inline

    Hi Jeff,

    Here's a little patch fixing a typo in smc91x.h.

    Regards,

    Tony

    --ReaqsoxgOBHFXBhH
    Content-Type: text/x-chdr; charset=us-ascii
    Content-Disposition: inline; filename="patch-fix-typo-smc91x.h"
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

Ugh. It's not like we want people saying "Hi there" in our changelogs.

		Linus
