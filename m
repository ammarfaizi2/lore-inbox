Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264040AbTCXC3o>; Sun, 23 Mar 2003 21:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264042AbTCXC3n>; Sun, 23 Mar 2003 21:29:43 -0500
Received: from ns2.snowman.net ([66.93.83.121]:51472 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S264040AbTCXC3n>;
	Sun, 23 Mar 2003 21:29:43 -0500
From: nick@snowman.net
Date: Sun, 23 Mar 2003 21:40:44 -0500 (EST)
To: Miles Bader <miles@gnu.org>
cc: Eli Carter <eli.carter@inet.com>,
       Mike Dresser <mdresser_l@windsormachine.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <buowuipzf5j.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.21.0303232139580.4607-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can get down to somewhere around 2... (Mips R5k w/ no l2
cache... painfull) why?  I appear to have missed the start of this thread
	Nick

On 24 Mar 2003, Miles Bader wrote:

> Eli Carter <eli.carter@inet.com> writes:
> > So, who can beat his 15.10 bogomips?  Anyone run <1 bogomips?
> 
> The normal systems I develop for have 4-6 bogomips (NEC V850E/MA1 @50MHz).
> 
> For debugging I often run linux on gdb's simulator, which probably has
> somewhere under 1 bogomips (the number reported is not correct because I
> have to lie to the kernel about the clock interrupt rate, as it can't
> handle the real value).  It's still quite usable interactively though
> (actually 2.5.x feels noticably better than 2.4.x in this situation)...
> 
> -Miles
> -- 
> 97% of everything is grunge
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

