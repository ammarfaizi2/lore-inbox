Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTIJNdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbTIJNdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:33:09 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:36331 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S263112AbTIJNdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:33:07 -0400
Date: Wed, 10 Sep 2003 15:33:04 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910133304.GI28964@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <20030910115259.GA28632@Synopsys.COM> <03ae01c37795$063561a0$5aaf7450@wssupremo> <20030910121143.GA28858@Synopsys.COM> <03fb01c37797$33f706a0$5aaf7450@wssupremo> <20030910122810.GA28990@Synopsys.COM> <043901c37798$23be1520$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <043901c37798$23be1520$5aaf7450@wssupremo>
X-Operating-System: vega Linux 2.6.0-test3 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 02:36:19PM +0200, Luca Veraldi wrote:
> > but it does imply "tested". And widely used. And well-known.
> 
> And inefficient, too.
> Sorry, but I use theory not popular convention to judge.

But theory is often far from practice ...

Theory is something which uses some abstraction to "model" reality. Which
often means oversimplification of the problem or simply the fact that a real
case has got much more (probably hidden) parameters affecting the problem.
Maybe these parameters are very hard to even detect at the FIRST sight.
That's why most software development starting from theory _BUT_ some "REAL
WORLD" benchmark/test should confirm the truth of that theory. Or even think
about relativity theory by Einstein: the theory is good, but it's even
better to prove it in the real life too: perturbation in the orbit of
Mercury, or affect to the visible position of stars at an eclipse. That was
the point when Einstein's theory bacome to be widely used by science.

So I thing it's no use to start a flame thread here. Implement that IPC
solution, and test it. If it becomes a good one, everybody will be happy
with your work. If not, at least you've tried, and maybe you will also
learn from it. Since Linux is open source, you have nothing to lose with
your implementation.

- Gábor (larta'H)
