Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKEVSS>; Sun, 5 Nov 2000 16:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbQKEVSI>; Sun, 5 Nov 2000 16:18:08 -0500
Received: from [63.95.87.168] ([63.95.87.168]:52498 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129121AbQKEVRx>;
	Sun, 5 Nov 2000 16:17:53 -0500
Date: Sun, 5 Nov 2000 16:17:52 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: gigabit ethernet small-packet performance
Message-ID: <20001105161752.A13140@xi.linuxpower.cx>
In-Reply-To: <200011051507.eA5F7KX30823@amsterdam.lcs.mit.edu> <20001105134518.E12776@xi.linuxpower.cx> <20001105224047.A18024@home.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20001105224047.A18024@home.ds9a.nl>; from ahu@ds9a.nl on Sun, Nov 05, 2000 at 10:40:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 10:40:48PM +0100, bert hubert wrote:
> On Sun, Nov 05, 2000 at 01:45:18PM -0500, Gregory Maxwell wrote:
> 
> > Hmm.. Kernel code written in C++..
> > You people are nuts. :)
> 
> Nobody benefits from having such a closed mind. While I don't wish to imply
> that C++ is 'ready' for general use in the kernel, there is a useful subset
> of C++ that might one day be.

I didn't mean it that way. I though it was interesting in light of the
earlier flame war. Esp considering they appear to be using virtual
functions.

The 'you people are nuts. :)' was meant as a positive statement. 
Don't you know? All breakthroughs come from crazy people. :)

> Oh, and please let us not launch another huge discussion about this subject.
> I just want to state that having a closed mind is not going to help us.

Their code speaks for itself. It outperforms the Linux code and is more
flexible. 

Although, I tend to see that as a case for additional optimization of the
current Linux code... C++ can be a very useful development tool with the
potential to increase modularity and simplify development. However,
run-time abstraction will always be a performance loss.

I was happy to see the prior flame war end with 'Let the code speak', I only
brought this up here to draw some attention to Click from a C++ in the kernel
prospective, i.e. They are using C++ in the kernel (without extensive kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
