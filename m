Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282854AbRK0IA0>; Tue, 27 Nov 2001 03:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282851AbRK0IAV>; Tue, 27 Nov 2001 03:00:21 -0500
Received: from queen.bee.lk ([203.143.12.182]:34208 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S282852AbRK0H7L>;
	Tue, 27 Nov 2001 02:59:11 -0500
Date: Tue, 27 Nov 2001 13:58:47 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, editors@newsforge.com,
        lwn@lwn.net
Subject: Re: Linux 2.4.16
Message-ID: <20011127135847.A22859@bee.lk>
In-Reply-To: <20011127083530.A13584@bee.lk> <Pine.LNX.4.33L.0111270551210.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0111270551210.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Nov 27, 2001 at 05:51:59AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 05:51:59AM -0200, Rik van Riel wrote:
> On Tue, 27 Nov 2001, Anuradha Ratnaweera wrote:
> > On Mon, Nov 26, 2001 at 10:30:08AM -0200, Marcelo Tosatti wrote:
> > >
> > > final:
> > > - Fix 8139too oops				(Philipp Matthias Hahn)
> >
> > Won't that be a good idea to keep the -final the same as the last -pre?
> 
> That's basically what happened. This 8139too fix is
> ONE LINE, in a self-contained piece of code.

It is still not okey to include even _small_ changes, because it is hard to
define what small is.  Although we are sure that is is going to break,
Murphey's laws may get in ...;)

So better have a _policy_ of not doing so.

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

If you've done six impossible things before breakfast, why not round it
off with dinner at Milliway's, the restaurant at the end of the universe?
		-- Douglas Adams, "The Restaurant at the End of the Universe"

