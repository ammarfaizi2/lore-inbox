Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTFCIDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTFCIDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:03:39 -0400
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:57820 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id S264607AbTFCIDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:03:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: Re: VIA CHIPSET KT 400 / 8235 troubleshooting
Date: Tue, 3 Jun 2003 08:17:04 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <bbhli0$v5j$1@ask.hswn.dk>
References: <0060478E58FDD611A4A200508BCF7BD97BF752@pleyel.chant.com>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: ask.hswn.dk 1054628224 31923 172.16.10.100 (3 Jun 2003 08:17:04 GMT)
X-Complaints-To: news@ask.hswn.dk
NNTP-Posting-Date: Tue, 3 Jun 2003 08:17:04 +0000 (UTC)
User-Agent: nn/6.6.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <0060478E58FDD611A4A200508BCF7BD97BF752@pleyel.chant.com> "Laurent Pierre (MIS)" <Pierre.Laurent2@eurotunnel.com> writes:

>> Motherboard : DFI AD77 ( KT 400 / 8235 chipset. ) 
>> Everytime , my pc hangs during the installation and i have the following
>> messages : 
>> - ESR value before enabling vector : 00000002 
>> I've tried to activate / deactivate APIC : No result. 

My KT400 motherboard (Soltek) requires me to boot with the "noapic"
parameter, or it will hang in a similar manner. Did you try that,
or did you just enable/disable the APIC in the BIOS ?

-- 
Henrik Storner <henrik@hswn.dk> 
