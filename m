Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSBYIc7>; Mon, 25 Feb 2002 03:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293348AbSBYIct>; Mon, 25 Feb 2002 03:32:49 -0500
Received: from [208.48.139.185] ([208.48.139.185]:41632 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S293347AbSBYIck>; Mon, 25 Feb 2002 03:32:40 -0500
Date: Mon, 25 Feb 2002 00:32:33 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org, Simon Kirby <sim@netnation.com>
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-ID: <20020225003233.A26113@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org, Simon Kirby <sim@netnation.com>
In-Reply-To: <3C771D29.942A07C2@starband.net> <20020222204456.O11156@work.bitmover.com> <3C77270A.1CBA02E8@zip.com.au> <20020225080742.GA3122@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020225080742.GA3122@netnation.com>; from sim@netnation.com on Mon, Feb 25, 2002 at 12:07:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 12:07:42AM -0800, Simon Kirby wrote:
> 
> Me too.  Everybody says "it's the final code that matters", but a lot of
> us would be more productive if the thing would just compile faster.  I've
> done the same (used 2723 during development/debugging) and it helped
> quite a lot.

Well, that's true if you spend most of your time waiting for the compiler to
run, but when it takes longer to compile AND runs slower
(http://www.cs.utk.edu/~rwhaley/ATLAS/gcc30.html) you lose on both counts!

Anyone have good benchmarks to run to compare raw kernel performance to see
how much using RedHat's recent (2.96) or 3.0 compilers to compile the kernel
perform vs the older compilers?

-Dave
