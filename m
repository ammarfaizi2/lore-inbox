Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUCAWVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUCAWVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:21:03 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:60370 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261456AbUCAWT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:19:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop	device?) on 2.6.*)
Date: Mon, 01 Mar 2004 23:18:59 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.03.01.22.18.59.135752@smurf.noris.de>
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net> <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net> <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net> <20040215194633.A8948@infradead.org> <20040216014433.GA5430@leto.cs.pocnet.net> <20040215175337.5d7a06c9.akpm@osdl.org> <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net> <1076900606.5601.47.camel@leto.cs.pocnet.net>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1078179539 6847 192.109.102.35 (1 Mar 2004 22:18:59 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 1 Mar 2004 22:18:59 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe Saout wrote:

> I posted a small description some time ago:

Thanks.

How do I specify the encryption algorithm's bit size? AES can use 128,
196, or 256 bits. Gues who didn't use the default (128) when creating the
file system on his keychain's USB thing  :-/

-- 
Matthias Urlichs
