Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266079AbUFELM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266079AbUFELM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 07:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUFELMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 07:12:55 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:34447 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266088AbUFELLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 07:11:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: 2.6.7-rc2-mm1
Date: Sat, 05 Jun 2004 13:07:52 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.05.11.07.51.780541@smurf.noris.de>
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011248.16303.dominik.karall@gmx.net> <20040601112418.GM2093@holomorphy.com> <20040602031842.60f48e35.pj@sgi.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1086433672 32404 192.109.102.35 (5 Jun 2004 11:07:52 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 5 Jun 2004 11:07:52 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul Jackson wrote:

> Just guessing, the problem is likely in the bk-scsi.patch,

Just noting, if you want the -mm patches as a BK tree so that you don't
have to guess quite that much ;-)  they're available as
bk://smurf.bkbits.net/linux-2.6.#-rc#-mm#.

Additional benefit: I pull from the various BK trees, instead of applying
Andrew's bk-* patches.

I try to be reasonably timely generating them.

-- 
Matthias Urlichs
