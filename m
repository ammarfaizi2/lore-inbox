Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUCKJfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUCKJfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:35:25 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:44482 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261156AbUCKJfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:35:19 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: 2.6.4-mm1
Date: Thu, 11 Mar 2004 10:34:28 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.03.11.09.34.22.286638@smurf.noris.de>
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311003023.6ae87569.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1078997668 17578 192.109.102.35 (11 Mar 2004 09:34:28 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Thu, 11 Mar 2004 09:34:28 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/
> 
> Needs this fix, if you use CONFIG_DEBUG_SPINLOCK
> 
Imported to BitKeeper:

bk://smurf.bkbits.net/linux-2.6.4-mm1

I have that process automated rather well now. If anybody wants the import
script (it can easily be adapted for other patch series), just ask.

-- 
Matthias Urlichs
