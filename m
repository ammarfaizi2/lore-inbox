Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311217AbSCLO3m>; Tue, 12 Mar 2002 09:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311216AbSCLO33>; Tue, 12 Mar 2002 09:29:29 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:47015 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311211AbSCLO1v>; Tue, 12 Mar 2002 09:27:51 -0500
Date: Tue, 12 Mar 2002 16:11:31 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Few questions about 2.5.6-pre3
In-Reply-To: <1015917775.4808.9.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0203121608400.32078-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Mar 2002, Robert Love wrote:

> I've never seen this.  I assume the box is SMP since you are hitting a
> BUG in the spin_unlock code?  I almost want to think this is an SMP bug
> (locking rules not being observed somewhere) and preemption is just
> accelerating the race.
> 
> Ohh wait - this is 2.5.6-pre3 ?
> 
> Can you try 2.5.6 final (or anything later)?  There is a bug with SMP
> and preempt and this could be it.  Let me know..

Its SMP kernel on UP box, i'll be testing 2.5.6 this evening so i'll give 
you a heads up tommorrow.

Cheers,
	Zwane


