Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUFEKwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUFEKwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 06:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUFEKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 06:52:49 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:36232 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263295AbUFEKvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 06:51:54 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: RE: removable media support on 2.6.x
Date: Sat, 05 Jun 2004 12:51:47 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.05.10.51.47.893693@smurf.noris.de>
References: <1118873EE1755348B4812EA29C55A9722AF023@esnmail.esntechnologies.co.in>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1086432708 28700 192.109.102.35 (5 Jun 2004 10:51:48 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 5 Jun 2004 10:51:48 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinu M. wrote:

> Is there some existing driver which addresses removable media on 2.6.x
> Kernel?

SCSI. USB sticks are SCSI disks in disguise; hotplugging works quite
well for them.

-- 
Matthias Urlichs
