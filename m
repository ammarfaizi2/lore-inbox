Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUJXIaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUJXIaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 04:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUJXIaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 04:30:25 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:46525 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261384AbUJXIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 04:30:22 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: 2.6.10-rc1 initramfs busted
Date: Sun, 24 Oct 2004 10:30:05 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.24.08.30.05.584232@smurf.noris.de>
References: <20041023133120.A28178@flint.arm.linux.org.uk>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1098606605 2133 192.109.102.35 (24 Oct 2004 08:30:05 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 24 Oct 2004 08:30:05 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Russell King wrote:

> A build using O= does this:

I already posted a small patch for this, three days ago.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

