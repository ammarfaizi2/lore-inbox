Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280343AbRKEILD>; Mon, 5 Nov 2001 03:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280339AbRKEIKp>; Mon, 5 Nov 2001 03:10:45 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:15082 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S280329AbRKEIKa>; Mon, 5 Nov 2001 03:10:30 -0500
Date: Mon, 5 Nov 2001 10:21:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Robert Love <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-ac5-preempt, overflow in cached memory stat?
In-Reply-To: <1004946998.806.0.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Nov 2001, Robert Love wrote:

> On Sat, 2001-11-03 at 04:51, Zwane Mwaikambo wrote:
> > I experienced a power loss and upon booting of the system, fsck was run on
> > my / partition (ext3). When it was done i noticed the following;
>
> ac7 contains a fix for cache memory accounting; I think it would fix
> your problem.  can you give it a try?  the preempt patch for ac6 should
> apply fine...
>
> 	Robert Love
>

Thanks, I just saw a thread discussing the very same issue i had, i'll
download both ac7 and the ac6 preempt patch and give it a try.

PS I know you keep hearing this, but that preempt patch makes for some
damn smooth interactive performance ;)

Regards,
	Zwane Mwaikambo

