Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285178AbRLFRNP>; Thu, 6 Dec 2001 12:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285179AbRLFRNF>; Thu, 6 Dec 2001 12:13:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:60818 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285178AbRLFRM4>; Thu, 6 Dec 2001 12:12:56 -0500
Date: Thu, 06 Dec 2001 09:11:53 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Henning Schmiedehausen <hps@intermeta.de>
cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <2607566231.1007629913@mbligh.des.sequent.com>
In-Reply-To: <1007632244.24677.1.camel@forge>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > We don't agree on any of these points.  Scaling to a 16 way SMP pretty much 
>> > ruins the source base, even when it is done by very careful people.
>> 
>> I'd say that the normal current limit on SMP machines is 8 way.
>> But you're right, we don't agree.  Time will tell who was right.
>> When I say I'm interested in 16 way scalability, I'm not talking about
>> SMP, so perhaps we're talking at slightly cross purposes.
> 
> Well I do remember those Sequent Symmetry machines from university which
> scaled to 24 processors and more. If I remember correctly they ran 16x
> 386 and 8x 486 in a single box (under Dynix?)

Actually they'd scale to about 30 Pentiums. But then again, note that I said
normal and current. Our Symmetry boxes fit neither of those criteria ;-)

M.

