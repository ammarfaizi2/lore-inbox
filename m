Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276507AbRJKPJK>; Thu, 11 Oct 2001 11:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276503AbRJKPJA>; Thu, 11 Oct 2001 11:09:00 -0400
Received: from ns.tasking.nl ([195.193.207.2]:25093 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S276381AbRJKPIm>;
	Thu, 11 Oct 2001 11:08:42 -0400
Date: Thu, 11 Oct 2001 17:08:47 +0200
From: Frank van Maarseveen <fvm@altium.nl>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too: NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20011011170847.A7877@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
In-Reply-To: <3BC5B313.10444AA@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC5B313.10444AA@colorfullife.com>; from manfred@colorfullife.com on Thu, Oct 11, 2001 at 04:56:19PM +0200
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 04:56:19PM +0200, Manfred Spraul wrote:
> 
> Do you use any user space tools to fix the link speed?
> 	mii-diag
> 	eth=0,0,<number>
> 	module parameter?

no

> What is the link partner? hub, switch, fixed 10-mbit, dual-speed hub?

10mb fixed hub:

	CentreCOM MR820TR
	IEEE 802.3 10BASE-T/10BASE2/AUI
	multiport micro hub/repeater
	
-- 
Frank
