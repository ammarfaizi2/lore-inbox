Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268841AbRG0Phi>; Fri, 27 Jul 2001 11:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268869AbRG0PhU>; Fri, 27 Jul 2001 11:37:20 -0400
Received: from abba.synaptique.co.uk ([213.86.145.226]:44921 "HELO
	host.domain.name") by vger.kernel.org with SMTP id <S268841AbRG0Pfc>;
	Fri, 27 Jul 2001 11:35:32 -0400
Date: Fri, 27 Jul 2001 16:35:34 +0100
From: Samuel Dupas <samuel@dupas.com>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel paging request at virtual address 3b617b05 ( was Re: swap_free: swap-space map bad (entry 00000100) )
Message-Id: <20010727163534.74a4e6c8.samuel@dupas.com>
In-Reply-To: <20010727082918.A27780@work.bitmover.com>
In-Reply-To: <20010727111313.1da63aca.samuel@dupas.com>
	<20010727162423.2fb6fc80.samuel@dupas.com>
	<20010727082918.A27780@work.bitmover.com>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001 08:29:18 -0700
Larry McVoy <lm@bitmover.com> wrote:
> On Fri, Jul 27, 2001 at 04:24:23PM +0100, Samuel Dupas wrote:
> > I change the kernel (now 2.2.19) and I still have the same problem. It
> > begin by a "Unable to handle kernel paging request at virtual address"
> 
> Did you change memory or CPU lately?  I had a pile of these yesterday 
> after we dropped in a 1.3Ghz K7.  Turned out our memory was border line,
> I swapped in some new mem and no more problems.

No I didn't change the hardware. The server is installed in our
colocation-center for 3 weeks but was not really used so far.
I discover theses lines in the logs and in fact the server restarts itself
when it fails.
And as I am a bit far from the server, I can't test a hardware changement
yet.

I want to know if it's an hardware problem or not, and if it's the hard
disk, the memory etc...

Any Idea ?

Thanks

Samuel
