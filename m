Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTBXNzu>; Mon, 24 Feb 2003 08:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTBXNzu>; Mon, 24 Feb 2003 08:55:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18304
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267104AbTBXNzs>; Mon, 24 Feb 2003 08:55:48 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030224050650.GI27135@holomorphy.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca>
	 <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com>
	 <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com>
	 <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com>
	 <20030224050650.GI27135@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046099212.1246.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 24 Feb 2003 15:06:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 05:06, William Lee Irwin III wrote:
> On Sun, Feb 23, 2003 at 08:56:16PM -0800, Larry McVoy wrote:
> > Furthermore, I can prove that isn't what you are talking about.  Show me
> > the performance gains you are getting on 4way systems from your changes.
> > Last I checked, things scaled pretty nicely on 4 ways.
> 
> Try 4 or 8 mkfs's in parallel on a 4x box running virgin 2.4.x.

You have strange ideas of typical workloads. The mkfs paralle one is a good
one though because its also a lot better on one CPU in 2.5

