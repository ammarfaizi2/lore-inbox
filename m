Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVK1R7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVK1R7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVK1R7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:59:24 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:33430 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932139AbVK1R7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:59:24 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer
 dereference
X-Message-Flag: Warning: May contain useful information
References: <20051126233736.GE3988@stusta.de> <52irud4pki.fsf@cisco.com>
	<20051128002523.GA31395@stusta.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 28 Nov 2005 09:59:17 -0800
In-Reply-To: <20051128002523.GA31395@stusta.de> (Adrian Bunk's message of
 "Mon, 28 Nov 2005 01:25:23 +0100")
Message-ID: <52psok1wne.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Nov 2005 17:59:18.0668 (UTC) FILETIME=[740A4CC0:01C5F445]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Adrian> Can you Cc me when forwarding it to Linus?

Looks like it went into Linus's tree directly from you (which is fine).

    Adrian> After it's in Linus' tree, Greg will accept it for the
    Adrian> 2.6.14 stable tree.

Is this really important enough for the stable tree?

 - R.
