Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267971AbTBVXhH>; Sat, 22 Feb 2003 18:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbTBVXhH>; Sat, 22 Feb 2003 18:37:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:63672 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267971AbTBVXhE>; Sat, 22 Feb 2003 18:37:04 -0500
Date: Sat, 22 Feb 2003 15:47:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, William Lee Irwin III <wli@holomorphy.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <4190000.1045957628@[10.10.2.4]>
In-Reply-To: <20030222232859.GC31268@work.bitmover.com>
References: <2080000.1045947731@[10.10.2.4]> <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca> <20030222221739.GF10411@holomorphy.com> <20030222232859.GC31268@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > ccNUMA worst-case latencies are not much different from decent 
>> > cluster (message-passing) latencies.
>> 
>> Not even close, by several orders of magnitude.
> 
> Err, I think you're wrong.  It's been a long time since I looked, but I'm
> pretty sure myrinet had single digit microseconds.  Yup, google rocks,
> 7.6 usecs, user to user.  Last I checked, Sequents worst case was around
> there, right?

Sequent hardware is very old. Go time a Regatta.

M.

