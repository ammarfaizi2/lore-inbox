Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSFCMzx>; Mon, 3 Jun 2002 08:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSFCMzw>; Mon, 3 Jun 2002 08:55:52 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:40463 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S315358AbSFCMzw>; Mon, 3 Jun 2002 08:55:52 -0400
Date: Mon, 3 Jun 2002 22:57:52 +1000
From: john slee <indigoid@higherplane.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
        "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>,
        linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
Message-ID: <20020603125752.GE12322@higherplane.net>
In-Reply-To: <3CFB21C5.27BBFB66@aitel.hist.no> <Pine.LNX.4.44.0206031050170.10836-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 10:51:34AM +0200, Zwane Mwaikambo wrote:
> On Mon, 3 Jun 2002, Helge Hafting wrote:
> 
> > I see this too.  I always thought it was the less-than-perfect ABIT BP6
> > loosing an irq or something.  (odd that it _always_ is the NIC that goes
> > though...)  I also have a k6 with the same NIC, and another
> > UP machine at work.  They never fail this way.
> > Could it be a SMP problem?
> 
> I wouldn't think so, i use it on SMP extensively without a hitch.

"me too" - have been using 3c905B cards in various SMP (and UP) boxes
for a couple of years now and they've never failed me, even on bp6.  in
fact i seem to have missed out on the plague of bp6 problems, even when
running dual 300a overclocked to 450.  strange.

j.

-- 
toyota power: http://indigoid.net/
