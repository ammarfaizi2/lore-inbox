Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTBVRJr>; Sat, 22 Feb 2003 12:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTBVRJr>; Sat, 22 Feb 2003 12:09:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34946
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267137AbTBVRJp>; Sat, 22 Feb 2003 12:09:45 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030222001618.GA19700@work.bitmover.com>
References: <96700000.1045871294@w-hlinder>
	 <20030222001618.GA19700@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045938019.5034.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 18:20:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 00:16, Larry McVoy wrote:
> In terms of the money and in terms of installed seats, the small Linux
> machines out number the 4 or more CPU SMP machines easily 10,000:1.
> And with the embedded market being one of the few real money makers
> for Linux, there will be huge pushback from those companies against
> changes which increase memory footprint.

I think people overestimate the numbner of large boxes badly. Several IDE
pre-patches didn't work on highmem boxes. It took *ages* for people to
actually notice there was a problem. The desktop world is still 128-256Mb
and some of the crap people push is problematic even there. In the embedded
space where there is a *ton* of money to be made by smart people a lot
of the 2.5 choices look very questionable indeed - but not all by any
means, we are for example close to being able to dump the block layer,
shrink stacks down by using IRQ stacks and other good stuff.

I'm hoping the Montavista and IBM people will swat each others bogons 8)

Alan

