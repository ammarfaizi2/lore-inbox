Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUITXlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUITXlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUITXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:14527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267404AbUITXk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:40:58 -0400
Date: Mon, 20 Sep 2004 16:44:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, fallow@op.pl, shrybman@aei.ca
Subject: Re: [PATCH, 2.6.9-rc2-mm1] V-5.0.1 ZAPHOD O(1) CPU Scdeduler
Message-Id: <20040920164444.71382d57.akpm@osdl.org>
In-Reply-To: <414F6732.1090804@bigpond.net.au>
References: <414F6732.1090804@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> A patch for the ZAPHOD O(1) Single Priority Array (SPA) CPU Scheduler 
> against the 2.6.9-rc2-mm1 kernel is available for download at:
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.9-rc2-mm1-spa_zaphod_FULL-v5.0.1?download>

hm, but that kernel already has nicksched.

I'll drop nicksched - please send a patch against next -mm.

Alternatively, run up a diff against
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 (which is a diff
against 2.6.9-rc2).

Thanks.
