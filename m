Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUBFTK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUBFTK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:10:58 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:55980 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265694AbUBFTK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:10:56 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: HFSPLus driver for Linux 2.6.
Date: Fri, 06 Feb 2004 20:09:54 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.06.19.09.54.348055@smurf.noris.de>
References: <402304F0.1070008@thock.com> <20040205191527.4c7a488e.akpm@osdl.org> <40231076.7040307@thock.com> <20040205200217.360c51ab.akpm@osdl.org> <1076051611.885.25.camel@gaston> <jeptcsxsb5.fsf@sykes.suse.de>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076094594 1318 192.109.102.35 (6 Feb 2004 19:09:54 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 6 Feb 2004 19:09:54 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andreas Schwab wrote:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> One thing we absolutely need too is a port of Apple's fsck for HFS+,
>> currently, the driver will refuse to mount read/write a "dirty"
>> HFS+ filesystem to avoid corruption, but that means we have to reboot
>> MacOS to fsck it then... 
> 
> Not reboot, but boot. MOL is your friend. :-)

OK, YOU tell that to my m68k Mac over there.  :-/

-- 
Matthias Urlichs

