Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264595AbRFPIg6>; Sat, 16 Jun 2001 04:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264596AbRFPIgs>; Sat, 16 Jun 2001 04:36:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22210 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264595AbRFPIgk>;
	Sat, 16 Jun 2001 04:36:40 -0400
Date: Sat, 16 Jun 2001 04:36:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Marc ZYNGIER <mzyngier@freesurf.fr>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <wrpn178u97l.fsf@hina.wild-wind.fr.eu.org>
Message-ID: <Pine.GSO.4.21.0106160427340.10605-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Jun 2001, Marc ZYNGIER wrote:

> >>>>> "Al" == Alexander Viro <viro@math.psu.edu> writes:
> 
> Al> Very odd. Could somebody try vanilla 2.4.6-pre1 on a PPC box? I _really_
> Al> doubt that it might be an architecture-specific problem in directory
> Al> code - it would simply fail the lookup for  /dev in that case.
> 
> I have 2.4.6-pre3 running. Machine is a PowerMac clone with a G3 CPU.
> It gets loads of bogus interrupts (known problem with this machine),
> but otherwise runs fine (that is, for the time being).

[snip]
 
> Been there, done that. Just works.
> Would 2.4.6-pre1 be a better test ? I can dig into that if you want.

Nah - just that 2.4.6-pre1 was the version where ext2 patch went in.

