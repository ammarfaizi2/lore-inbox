Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUFRGK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUFRGK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 02:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUFRGK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 02:10:58 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:22474 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263663AbUFRGK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 02:10:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: SATA 3112 errors on 2.6.7
Date: Fri, 18 Jun 2004 08:08:03 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.18.06.08.03.257944@smurf.noris.de>
References: <20040617210751.GA28519@pool-141-154-165-127.wma.east.verizon.net> <Pine.GSO.4.33.0406172012220.25702-100000@sweetums.bluetronic.net>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1087538883 27667 192.109.102.35 (18 Jun 2004 06:08:03 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 18 Jun 2004 06:08:03 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ricky Beam wrote:

>>Current sda: sense key Medium Error

>There's likely nothing wrong with your drives.  Something about that
>driver and the hardware aren't playing nice.

What does the drive's SMART error log report?

I would consider swapping the power supply. Last year I had *four* 120 GB
drives fail on me before I changed the thing. Zero problems since.

-- 
Matthias Urlichs
