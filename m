Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDYTKJ>; Wed, 25 Apr 2001 15:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDYTJ7>; Wed, 25 Apr 2001 15:09:59 -0400
Received: from team.iglou.com ([192.107.41.45]:21975 "EHLO iglou.com")
	by vger.kernel.org with ESMTP id <S131386AbRDYTJn>;
	Wed, 25 Apr 2001 15:09:43 -0400
Date: Wed, 25 Apr 2001 15:09:42 -0400
From: Jeff Mcadams <jeffm@iglou.com>
To: linux-kernel@vger.kernel.org
Subject: l2tpd and kernel support...
Message-ID: <20010425150942.A8061@iglou.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is definitely 2.5 material here since I have exactly 0 lines of
code for kernel support at this point, but...wanted to put it on some
radar screens.

Scott Balmos, David Stipp and myself and begun to do some development
work on the l2tpd software that Mark Spencer originally wrote.  We've
made several major improvements to it at this point and have made great
strides in bringing the software up to date with respect to RFC
compliance.

I'm of the opinion that, eventually l2tpd will need to move some of the
L2TP processing into the kernel.  Like I said, I don't have even a
single line of code written at this point, but I've been doing lot's of
reading and learning in preperation for this.  I'm starting to do some
playing around to get up to speed on kernel module programming and hope
to have some code available to do some of this within a fairly short
period of time (mostly dependant on how many of those tuits I get).

Anyway...I wanted to bring this up to get on some radar screens and see
if anyone had any interest in helping this effort out.

If you'd like to see where we've gone with the code so far, feel free to
check out http://www.sourceforge.net/projects/l2tpd/

-- 
Jeff McAdams                            Email: jeffm@iglou.com
Head Network Administrator              Voice: (502) 966-3848
IgLou Internet Services                        (800) 436-4456
