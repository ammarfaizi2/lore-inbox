Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266471AbUBFFK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 00:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266483AbUBFFK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 00:10:56 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:63438 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266471AbUBFFKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 00:10:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: HFSPLus driver for Linux 2.6.
Date: Fri, 06 Feb 2004 06:03:52 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.06.05.03.51.679598@smurf.noris.de>
References: <402304F0.1070008@thock.com> <20040205191527.4c7a488e.akpm@osdl.org> <40231076.7040307@thock.com> <20040205200217.360c51ab.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076043832 29560 192.109.102.35 (6 Feb 2004 05:03:52 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 6 Feb 2004 05:03:52 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> Dylan Griffiths <dylang+kernel@thock.com> wrote:
>>
>> 	I don't remember where I grabbed this driver, I only know it's much
>>  more current than the one at
>>  http://sourceforge.net/projects/linux-hfsplus.
> 
> Sorry, that's a showstopper.  We need to understand who the maintenance
> team is, and evaluate their preparedness to maintain this code long-term.
> 
That probably was http://www.ardistech.com/hfsplus/. Their latest release
is from mid-December.

> We don't want to be adding yet another rarely-used filesystem which has no
> visible maintenance team.
> 
The Mac-m68k and the Mac-PPC people would probably disagree about the
"rarely-used" part. I do agree that adding a filesystem, no matter how
widely used, without at least somebody to liaise between the kernel people
and the authors is a bad idea.

-- 
Matthias Urlichs
