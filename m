Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWIIBhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWIIBhx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 21:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWIIBhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 21:37:53 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:24485 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751302AbWIIBhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 21:37:52 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [-stable patch] pci_ids.h: add some VIA IDE identifiers
Date: Sat, 09 Sep 2006 11:37:38 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <2m64g2du1g408feb463dhs5mdre462554l@4ax.com>
References: <20060909001925.GB1032@redhat.com>
In-Reply-To: <20060909001925.GB1032@redhat.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 20:19:25 -0400, Dave Jones <davej@redhat.com> wrote:

>This never made it into 2.6.17.12
>Without it, this happens..
>
>drivers/ide/pci/via82cxxx.c:85: error: 'PCI_DEVICE_ID_VIA_8237A' undeclared here (not in a function)
>
>	Dave

patching file include/linux/pci_ids.h
Hunk #1 succeeded at 1235 (offset 12 lines).
Hunk #3 succeeded at 1284 (offset 12 lines).

Works here ;)

Grant.
