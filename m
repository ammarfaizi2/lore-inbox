Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267901AbTBVUZZ>; Sat, 22 Feb 2003 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbTBVUZY>; Sat, 22 Feb 2003 15:25:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8835
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267901AbTBVUZX>; Sat, 22 Feb 2003 15:25:23 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030222200521.GD10411@holomorphy.com>
References: <96700000.1045871294@w-hlinder>
	 <20030222001618.GA19700@work.bitmover.com>
	 <1045938019.5034.9.camel@irongate.swansea.linux.org.uk>
	 <20030222200521.GD10411@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045949730.5685.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 21:35:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 20:05, William Lee Irwin III wrote:
> On Sat, Feb 22, 2003 at 06:20:19PM +0000, Alan Cox wrote:
> > I'm hoping the Montavista and IBM people will swat each others bogons 8)
> 
> Sounds like a bigger win for the bigboxen, since space matters there,
> but large-scale SMP efficiency probably doesn't make a difference to
> embedded (though I think some 2x embedded systems are floating around).

Smaller cleaner code is a win for everyone, and it often pays off in ways
that are not immediately obvious. For example having your entire kernel
working set and running app fitting in the L2 cache happens to be very
good news to most people.

Alan

