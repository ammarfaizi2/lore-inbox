Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284729AbRLEVPq>; Wed, 5 Dec 2001 16:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbRLEVPg>; Wed, 5 Dec 2001 16:15:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52104 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284729AbRLEVPZ>; Wed, 5 Dec 2001 16:15:25 -0500
Date: Wed, 05 Dec 2001 13:14:45 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <2535737837.1007558085@mbligh.des.sequent.com>
In-Reply-To: <20011205130547.X11801@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't agree on any of these points.  Scaling to a 16 way SMP pretty much 
> ruins the source base, even when it is done by very careful people.

I'd say that the normal current limit on SMP machines is 8 way.
But you're right, we don't agree.  Time will tell who was right.
When I say I'm interested in 16 way scalability, I'm not talking about
SMP, so perhaps we're talking at slightly cross purposes.
 
> Seriously, I went through this at SGI, that's exactly what they did, and it
> was a huge mistake and it never worked.

You seem to make this odd logical deduction quite a bit - you (or company X)
has tried concept X before. Their implementation didn't work. Therefore the
concept is bad. It's not particularly convincing as an argument style to others.
But I understand that it makes *you* want to try something else.

Martin.

