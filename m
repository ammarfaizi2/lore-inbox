Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRHJJTT>; Fri, 10 Aug 2001 05:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbRHJJS7>; Fri, 10 Aug 2001 05:18:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55657 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266448AbRHJJSs>; Fri, 10 Aug 2001 05:18:48 -0400
To: jury gerold <geroldj@grips.com>
Cc: Thodoris Pitikaris <thodoris@cs.teiher.gr>, linux-kernel@vger.kernel.org
Subject: Re: is this a bug?
In-Reply-To: <3B6FD644.7020409@cs.teiher.gr> <3B716E0A.8030005@grips.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2001 03:12:06 -0600
In-Reply-To: <3B716E0A.8030005@grips.com>
Message-ID: <m1g0b0th21.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jury gerold <geroldj@grips.com> writes:

> I have the same motherboard, same chipset, same CPU and the same crash.
> No memory test cpu burn UDMA on/off, replace or remove of components
> did any good.
> Then i replaced the 100mhz SDRAM with a 133mhz and it is 100 % stable since
> then.
> 
> No matter which compiler, kernel version, cputype.
> It simply works now.

Do you happen to have the SDRAM timings of the two sets of DIMMS?
It would be interesting to see what changed besides the clock speed on
the DIMMS.  I'm assuming your PC133 DIMMs are running at at 133Mhz,
and you aren't over clocking anything.

Eric
