Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266829AbUFYSdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266829AbUFYSdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUFYSdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:33:11 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:35558 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266829AbUFYSdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:33:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Fri, 25 Jun 2004 20:32:37 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.25.18.32.36.821877@smurf.noris.de>
References: <40DC38D0.9070905@kolivas.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1088188357 28621 192.109.102.35 (25 Jun 2004 18:32:37 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 25 Jun 2004 18:32:37 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> +// interactive - interactive tasks get longer intervals at best
> priority

Hmmm... IIRC, C++ comments are frowned upon in the kernel.

Other than that: thanks for the work. Your comments seem to indicate that
INYO the staircase scheduler is ready for "real-world" kernels. Correct?

-- 
Matthias Urlichs
