Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVBHR21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVBHR21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVBHR21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:28:27 -0500
Received: from gprs214-192.eurotel.cz ([160.218.214.192]:28826 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261600AbVBHR2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:28:23 -0500
Date: Tue, 8 Feb 2005 18:27:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050208172714.GA1115@elf.ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207145100.6208b8b9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I wonder if reverting the patch will restore the old behaviour?

Yes, this fixes it: kylix application now works for me.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
