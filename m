Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbSLQW3A>; Tue, 17 Dec 2002 17:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267169AbSLQW3A>; Tue, 17 Dec 2002 17:29:00 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:52945 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267164AbSLQW27>;
	Tue, 17 Dec 2002 17:28:59 -0500
Date: Tue, 17 Dec 2002 17:34:53 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.52 PNP failure
Message-ID: <Pine.LNX.4.51.0212171730020.7058@nqynaqf.yrkvatgba.voz.pbz>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hand transcribed, so probably missing something important ...

Oops: 0000
Eip:  0060:[<c01cdbf3>] Not tainted
EIP is at compare_pnp_id+0x4f/0x78
Call Trace:
[<c01cfa43>] pnp_name_device+0x23/0x58
[<c01cd9af>] __pnp_add_device+0xf/0xc8
[<c01cdab4>] pnp_add_device+0x4c/0x54
[<c010509b>] init+0x33/0x188
[<c0105068>] init+0x0/0x188
[<c0109211>] kernel_thread_helper+0x5/0xc

<0>Kernel panic: Attempted to kill init!

-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
