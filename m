Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRLQPpS>; Mon, 17 Dec 2001 10:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbRLQPpA>; Mon, 17 Dec 2001 10:45:00 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:39183 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S280583AbRLQPoq>;
	Mon, 17 Dec 2001 10:44:46 -0500
Date: Mon, 17 Dec 2001 08:38:02 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Benjamin LaHaise <bcrl@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <20011217083802.A25219@hq2>
In-Reply-To: <20011215134711.A30548@redhat.com> <Pine.LNX.4.33.0112152235340.26748-100000@localhost.localdomain> <20011217160426.U2431@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217160426.U2431@athlon.random>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 04:04:26PM +0100, Andrea Arcangeli wrote:
> If somebody wants such 1% of ram back he can buy another dimm of ram and
> plug it into his hardware. I mean such 1% of ram lost is something that
> can be solved by throwing a few euros into the hardware (and people buys
> gigabyte boxes anyways so they don't need all of the 100% of ram), the
> other complexy cannot be solved with a few euros, that can only be
> solved with lots braincycles and it would be a maintainance work as
> well. Abstraction and layering definitely helps cutting down the
> complexity of the code.

I agree with all your arguments up to here. But being able to run Linux
in 4Meg or even 8M is important to a very large class of applications. 
Even if you are concerned mostly about bigger systems, making sure NT
remains at a serious disadvantage in the embedded boxes is key because
MS will certainly hope to use control of SOHO routers, set-top boxes
etc to set "standards" that will improve their competitivity in desktop
and beyond. It would be a delicious irony if MS were able to re-use
against Linux the "first control low end" strategy that allowed them 
vaporize the old line UNIXes, but irony is not as satisfying as winning.

