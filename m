Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318849AbSH1Nuy>; Wed, 28 Aug 2002 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSH1Nuy>; Wed, 28 Aug 2002 09:50:54 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:1966 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318849AbSH1Nuy>;
	Wed, 28 Aug 2002 09:50:54 -0400
Date: Wed, 28 Aug 2002 07:53:19 -0600
From: yodaiken@fsmlabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: yodaiken@fsmlabs.com, Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
Message-ID: <20020828075319.A24146@hq.fsmlabs.com>
References: <20020827145631.B877@hq.fsmlabs.com> <Pine.LNX.3.95.1020828080308.14759A-101000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020828080308.14759A-101000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Aug 28, 2002 at 08:18:25AM -0400
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 08:18:25AM -0400, Richard B. Johnson wrote:
> No, no, no. There is no such port read that takes 18 microseconds, even
> on old '386 machines with real ISR slots. A port read on those took
> almost exactly 300 nanoseconds and, in fact, was the limiting factor
> for the programmed I/O devices on the ISA bus.

Amazing how they can do that with a bus clock that is much slower -)



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

