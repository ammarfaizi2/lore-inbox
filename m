Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUBPKUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 05:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUBPKUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 05:20:07 -0500
Received: from gprs154-91.eurotel.cz ([160.218.154.91]:15233 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265504AbUBPKUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 05:20:02 -0500
Date: Mon, 16 Feb 2004 11:19:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, iod00d@hp.com,
       ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-ID: <20040216101924.GA335@elf.ucw.cz>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com> <20040128172004.GB5494@cup.hp.com> <20040128184137.616b6425.ak@suse.de> <16408.30.896895.980121@napali.hpl.hp.com> <20040128195246.47a84498.ak@suse.de> <16408.3157.336306.812481@napali.hpl.hp.com> <20040128203915.22d84e8d.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128203915.22d84e8d.ak@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> But when printed in Linux they will report it to the linux maintainer or their 
> distribution vendor.  "My Linux is buggy and giving these weird messages" And they
> are both in no position at all to do something about it. 

What about new KERN_HWBUG loglevel?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
