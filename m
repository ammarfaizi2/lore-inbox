Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUJIXmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUJIXmi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUJIXmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:42:38 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:8683 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S267571AbUJIXk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:40:59 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Sun, 10 Oct 2004 01:40:26 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.09.23.40.25.966608@smurf.noris.de>
References: <41677E4D.1030403@mvista.com> <1097304045.1442.166.camel@krustophenia.net> <1097307234.13748.1.camel@dhcp153.mvista.com> <1097307766.1442.168.camel@krustophenia.net>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1097365226 10066 192.109.102.35 (9 Oct 2004 23:40:26 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 9 Oct 2004 23:40:26 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee Revell wrote:

> On Sat, 2004-10-09 at 03:33, Daniel Walker wrote:
>> Do you have 4k stacks turned off? The docs make note of this.
>> 
> 
> My mistake, it works now.
> 
Actually, if 4k stacks don't work with RT turned on, this exclusion should
be encoded in the appropriate Kconfig file(s).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

