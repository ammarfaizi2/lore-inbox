Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSA1UEQ>; Mon, 28 Jan 2002 15:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSA1UD3>; Mon, 28 Jan 2002 15:03:29 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:31621 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289362AbSA1UCE>;
	Mon, 28 Jan 2002 15:02:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Momchil Velikov <velco@fadata.bg>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Date: Mon, 28 Jan 2002 21:06:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "" <simon@baydel.com>, Tim Schmielau <tim@physik3.uni-rostock.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com> <E16VHH9-0000Ba-00@starship.berlin> <87k7u2jm2v.fsf@fadata.bg>
In-Reply-To: <87k7u2jm2v.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VI3J-0000C4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 08:46 pm, Momchil Velikov wrote:
> >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> >> Is this asm syntax documented anywhere ? 
> 
> Daniel> It's painful, isn't it?  And no, I don't know where it's documented.
> 
> It is documented in "Using and Porting GNU Compiler Collection"
> http://gcc.gnu.org/onlinedocs/gcc-3.0.3/gcc_5.html#SEC103

I suppose we could dignify that with the term 'documentation'.  (To me, it 
reads more like a tutorial than a reference work, though as always I'm 
grateful to RMS and the FSF for having contributed this.  And the price can't 
be beat.)

Do you know where to find documentation for the assembly instructions 
themselves?

-- 
Daniel
