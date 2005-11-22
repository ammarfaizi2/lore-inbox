Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVKVDYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKVDYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKVDX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:23:59 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:51909 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750750AbVKVDX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:23:59 -0500
Message-ID: <43829080.7040706@student.ltu.se>
Date: Tue, 22 Nov 2005 04:29:04 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm2] net: Fix compiler-error on atyfb_base.c when !CONFIG_PCI
References: <20051122022652.6806.10075.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051122022652.6806.10075.sendpatchset@thinktank.campus.ltu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:

>diff -Narup a/drivers/net/dgrs.c b/drivers/net/dgrs.c
>  
>
Should of course be:

diff -Narup a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c


Lacy cut 'n' paste, sorry about that.
Richard
