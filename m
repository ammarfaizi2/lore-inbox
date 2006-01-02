Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWABRF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWABRF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWABRF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:05:28 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:42764 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750902AbWABRF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:05:26 -0500
Message-ID: <43B95D20.3060401@gentoo.org>
Date: Mon, 02 Jan 2006 17:04:32 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Jo=E3o_Esteves?= <joao.m.esteves@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via VT 6410 Raid Controller
References: <200601021253.10738.joao.m.esteves@netcabo.pt> <43B92706.8010402@gentoo.org> <200601021647.27453.joao.m.esteves@netcabo.pt>
In-Reply-To: <200601021647.27453.joao.m.esteves@netcabo.pt>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please use Reply-to-all.

João Esteves wrote:
> Thank you Daniel:
> 
> I inserted the patch, compiled the Kernel and it works fine (it appears in 
> Lilo as custom kernel), except that I still do not see the Pata HDD.

Can you explain what you mean by you don't "see" it? Where are you looking?

You could also post the output of:
	dmesg
	lspci
	lspci -n

> Is there any modification I must do to the patch source code to make it 
> specific to VT 6410?

No.

Daniel
