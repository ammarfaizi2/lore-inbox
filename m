Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263252AbUDUQEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUDUQEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUDUQEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:04:48 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:59653 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263252AbUDUQEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:04:47 -0400
Date: Thu, 22 Apr 2004 00:08:29 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm1
In-Reply-To: <20040421014544.37942eb4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404220005120.16711@donald.themaw.net>
References: <20040421014544.37942eb4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.2, required 8,
	IN_REP_TO, NO_REAL_NAME, REFERENCES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like there's no IDS defined for the Creator cards on sparc.

If only I could build a kernel on my little Ultra. Sigh.
I don't even have to fight the kids to use it.

In file included from drivers/char/drm/ffb_drv.c:336:
drivers/char/drm/drm_drv.h:545: error: `DRIVER_PCI_IDS' undeclared here 
(not in a function)
drivers/char/drm/drm_drv.h:545: error: initializer element is not constant
drivers/char/drm/drm_drv.h:545: error: (near initialization for 
`ffb_pciidlist[0 ]')
drivers/char/drm/ffb_drv.c:225: warning: `ffb_count_card_instances' 
defined but not used

