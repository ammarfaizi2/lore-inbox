Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRBINBx>; Fri, 9 Feb 2001 08:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130858AbRBINBn>; Fri, 9 Feb 2001 08:01:43 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:33529 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130461AbRBINBf>; Fri, 9 Feb 2001 08:01:35 -0500
Date: Fri, 9 Feb 2001 11:01:15 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Kurt Roeckx <Q@ping.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <20010209025406.A243@ping.be>
Message-ID: <Pine.LNX.4.21.0102091100060.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0102091100062.2378@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Kurt Roeckx wrote:

> I just tested ac8.
> 
> If I run this test, the system gets really slow.  It takes about
> a second between the time I press a key, and the time it appears
> on the screen.  The load goes way up.  Everything seems to block.

I'm sorry, but ... what test ?
And how do older kernels run the same thing ?

> It ran for serval minutes.  The process itself took about 1
> minutes of CPU time, and so did kswapd.  It took atleast 5
> minutes real time.
> 
> I once did just the same with 2.4.0, it took more like 30
> minutes then, and I ended up killing the process myself.

So the kernel's behaviour has improved ?

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
