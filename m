Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310570AbSCPUNB>; Sat, 16 Mar 2002 15:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310577AbSCPUMw>; Sat, 16 Mar 2002 15:12:52 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:15884 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310576AbSCPUMo>;
	Sat, 16 Mar 2002 15:12:44 -0500
Date: Sat, 16 Mar 2002 13:08:06 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316130806.A21439@hq.fsmlabs.com>
In-Reply-To: <15507.41057.35660.355874@napali.hpl.hp.com> <Pine.LNX.4.33.0203161144340.31971-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0203161144340.31971-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 11:58:22AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:58:22AM -0800, Linus Torvalds wrote:
>    This implies that the TLB should be split into a L1 and a L2, for all 
>    the same reasons you split other caches that way (and with the L1
>    probably being duplicated among all memory units)

AMD claims  L1, L2 and with hammer an 
I/D split as well. But no TLB load instruction as
far as I can tell


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

