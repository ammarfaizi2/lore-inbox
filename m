Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVKNPYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVKNPYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVKNPYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:24:55 -0500
Received: from rtr.ca ([64.26.128.89]:46995 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751151AbVKNPYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:24:55 -0500
Message-ID: <4378AC40.4020506@rtr.ca>
Date: Mon, 14 Nov 2005 10:24:48 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114143248.GA3859@gemtek.lt>
In-Reply-To: <20051114143248.GA3859@gemtek.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas wrote:
>
> EIP always is cache_alloc_refill() function. Full messages are available
> here: http://www.gemtek.lt/~zilvinas/ipw2200-syslog.gz

Ahh..  I also had a nasty VM related oops with this kernel,
as reported here under the topic "2.6.15-rc1: kswapd crash".

Maybe there is something broken.. ?
