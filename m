Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUBOJip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBOJip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:38:45 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:38830 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264392AbUBOJio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:38:44 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Hard drive fault prediction
Date: Sun, 15 Feb 2004 10:25:02 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.15.09.25.02.357163@smurf.noris.de>
References: <7A25937D23A1E64C8E93CB4A50509C2A0310F0B9@stca204a.bus.sc.rolm.com> <1076790000.10391.13.camel@ssatchell1.pyramid.net>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076837102 14482 192.109.102.35 (15 Feb 2004 09:25:02 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 15 Feb 2004 09:25:02 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen Satchell wrote:

> Are there any drive-independent error counters I can monitor in 2.4 to
> be able to detect drive failures early?

S.M.A.R.T.

You can tell most drives to do a nondisruptive background check.

-- 
Matthias Urlichs
