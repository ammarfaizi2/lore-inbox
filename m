Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270631AbRHNSjZ>; Tue, 14 Aug 2001 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270632AbRHNSjO>; Tue, 14 Aug 2001 14:39:14 -0400
Received: from cardinal0.Stanford.EDU ([171.64.15.238]:51869 "EHLO
	cardinal0.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S270631AbRHNSjD>; Tue, 14 Aug 2001 14:39:03 -0400
Date: Tue, 14 Aug 2001 09:28:13 -0700 (PDT)
From: Ted Unangst <tedu@stanford.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: memory compress tech...
In-Reply-To: <fa.j58merv.u5aqqi@ifi.uio.no>
Message-ID: <Pine.GSO.4.31.0108140924260.3860-100000@cardinal0.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Martin Dalecki wrote:

> Ignacio Vazquez-Abrams wrote:
> >
> > I think he said it best. There may be uses for memory-compression technology,
> > but does that make the slow-down worthwhile?
>
> Please read the corresponding research papers by IBM on this
> topic. It's all NOT ABOUT RAM size. It is all bout BUS BADWIDTH!
> At least if you do it properly - namely in hardware... ;-)

maybe for compressing swap?  you have to read less data off the disk,
which is faster.  and the processor is probably idling anyway, waiting on
disk.






--
"The brave men who died in Vietnam, more than 100% of which were
black, were the ultimate sacrifice."
      - M. Barry, Mayor of Washington, DC

