Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUBTJts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267771AbUBTJts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:49:48 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:50587 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S267769AbUBTJtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:49:46 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Unicode normalization (userspace issue, but what the heck)
Date: Fri, 20 Feb 2004 10:48:06 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.20.09.48.06.350631@smurf.noris.de>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <pan.2004.02.15.03.33.48.209951@smurf.noris.de> <c0ujpq$3r5$1@terminus.zytor.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1077270486 28540 192.109.102.35 (20 Feb 2004 09:48:06 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 20 Feb 2004 09:48:06 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, H. Peter Anvin wrote:
> By author:    Matthias Urlichs <smurf@smurf.noris.de>
>> Example: is an Ã¡ one character, or is it an a
>> followed by a composing ÂŽ?

Nope, I didn't write that, at least not that way...

Presumably I shouldn't post in UTF-8 if Latin-1(5) is sufficient, but
then that's part of the reason we're having this discussion, so there. ;-)

-- 
Matthias Urlichs
