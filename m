Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUDRVBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUDRVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 17:01:10 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:9476 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264183AbUDRVBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 17:01:08 -0400
Message-ID: <4082ECD9.5080308@myrealbox.com>
Date: Sun, 18 Apr 2004 14:02:17 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; DragonFly i386; en-US; rv:1.7b) Gecko/20040416
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Jochens <aj@andaco.de>
CC: davem@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
References: <20040418135534.GA6142@andaco.de>
In-Reply-To: <20040418135534.GA6142@andaco.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jochens wrote:
> The Debian distribution recently removed the tg3 Gigabit Ethernet driver
> from its 2.6 kernels because it contains binary-only firmware, 
> i.e. software without source code, which violates the 
> Debian Free Software Guildelines.
> 
> I not a kernel developer, but I looked at the tg3 driver 
> and it seemed that it might work even without the firmware parts.

Your patch works fine for me on my ASUA A7V8X with BCM5702 rev2.
