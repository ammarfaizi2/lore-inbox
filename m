Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbULSTtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbULSTtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 14:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULSTtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 14:49:03 -0500
Received: from gprs215-234.eurotel.cz ([160.218.215.234]:51585 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261333AbULSTtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 14:49:00 -0500
Date: Sun, 19 Dec 2004 20:48:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
Message-ID: <20041219194844.GB1432@elf.ucw.cz>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is a device driver to enable new hardware.  The new hardware is
> the TPM chip as described by specifications at trustedcomputinggroup.org.
> The TPM chip will enable you to use hardware to securely store and protect
> your keys and personal data.  To use the chip according to the 
> specification, you will need the Trusted Software Stack (TSS) of which an 
> implementation for Linux is available at: 
> http://sourceforge.net/projects/trousers.

Could we get some [short] description of what this chip does and
userland intereface into Documentation/?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
