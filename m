Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRHIAnN>; Wed, 8 Aug 2001 20:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHIAnE>; Wed, 8 Aug 2001 20:43:04 -0400
Received: from rj.SGI.COM ([204.94.215.100]:37797 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S269641AbRHIAmz>;
	Wed, 8 Aug 2001 20:42:55 -0400
Subject: Re: Problem with Linux 2.4.7 and builtin eepro on Intel's EEA2
	motherboard.
From: Florin Andrei <florin@sgi.com>
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
In-Reply-To: <3B704BBE.A3AA1C99@candelatech.com>
In-Reply-To: <3B704BBE.A3AA1C99@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Aug 2001 17:42:54 -0700
Message-Id: <997317775.19780.40.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Aug 2001 13:12:46 -0700, Ben Greear wrote:
> The driver seems to lock up for a while and then recover...
> 
> Aug  7 11:55:19 lanf1 last message repeated 5 times
> Aug  7 11:56:04 lanf1 last message repeated 21 times
> Aug  7 11:56:07 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out

Same hardware, same problem, only worse: for me, it locks up forever!

Had this problem with several 2.4.x versions, then switched to Intel's
driver. I'm using the Intel driver now, with 2.4.7, and i have no
problem.

-- 
Florin Andrei

