Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289381AbSA1US4>; Mon, 28 Jan 2002 15:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSA1UPe>; Mon, 28 Jan 2002 15:15:34 -0500
Received: from [217.9.226.246] ([217.9.226.246]:51584 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S289381AbSA1UPS>; Mon, 28 Jan 2002 15:15:18 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "" <simon@baydel.com>, Tim Schmielau <tim@physik3.uni-rostock.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com>
	<E16VHH9-0000Ba-00@starship.berlin> <87k7u2jm2v.fsf@fadata.bg>
	<E16VI3J-0000C4-00@starship.berlin>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <E16VI3J-0000C4-00@starship.berlin>
Date: 28 Jan 2002 22:14:42 +0200
Message-ID: <87d6zujkr1.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:

Daniel> On January 28, 2002 08:46 pm, Momchil Velikov wrote:
>> >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
>> >> Is this asm syntax documented anywhere ? 
>> 
Daniel> It's painful, isn't it?  And no, I don't know where it's documented.
>> 
>> It is documented in "Using and Porting GNU Compiler Collection"
>> http://gcc.gnu.org/onlinedocs/gcc-3.0.3/gcc_5.html#SEC103

Daniel> I suppose we could dignify that with the term 'documentation'.  (To me, it 
Daniel> reads more like a tutorial than a reference work, though as always I'm 
Daniel> grateful to RMS and the FSF for having contributed this.  And the price can't 
Daniel> be beat.)

Daniel> Do you know where to find documentation for the assembly instructions 
Daniel> themselves?

The appropriate place would be the processor's reference manual.

