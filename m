Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbRHGPi3>; Tue, 7 Aug 2001 11:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbRHGPiL>; Tue, 7 Aug 2001 11:38:11 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:15611 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S268934AbRHGPh6>; Tue, 7 Aug 2001 11:37:58 -0400
Date: Tue, 7 Aug 2001 08:43:59 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap
In-Reply-To: <tghevjnbuy.fsf@mercury.rus.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.33.0108070825410.6350-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Aug 2001, Florian Weimer wrote:

> David Maynor <david.maynor@oit.gatech.edu> writes:
>
> > But is the 10% perf hit really gaining you anything, expect to quell
> > your paranoia. What is next, an encrypted /proc so that possible
> > attackers can't gain information about running processes?
>
> This is not about paranoia, this is about stolen notebooks.
>
> (And you can't easily add hundreds of megabytes to such systems
> usually.)

yeah, that's true, but on older ones (like my toshiba portege 3010 which
has the system maximum of 96MB ) you may not be able to afford the
performance hit either(pentium 266,dma mode0 or pio disk,430tx chipset
and all it's attendant memory performance issues with more than 64mb).

on a more modern unit (like my toshiba 2805 which has 384MB) the
performance hit probably isn't a big deal but I probably don't need swap
that much either.

joelja

>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


