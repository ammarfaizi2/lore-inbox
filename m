Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135905AbREEBHa>; Fri, 4 May 2001 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREEBHU>; Fri, 4 May 2001 21:07:20 -0400
Received: from colorfullife.com ([216.156.138.34]:59662 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S135905AbREEBHL>;
	Fri, 4 May 2001 21:07:11 -0400
Message-ID: <3AF35246.420B2E1A@colorfullife.com>
Date: Sat, 05 May 2001 03:07:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: whitney@math.berkeley.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: How to debug a 2.4.4 tulip problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> What information should I gather when the card is wedged to aid in 
> debugging? Is 'lspci -xxx' enough? Any suggestions would be welcome. 
>
tulip-diag from www.scyld.com.

Do you know if transmit or receive is slow? tcpdump on both ends of the
ping might help.
