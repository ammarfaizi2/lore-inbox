Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318589AbSHADVp>; Wed, 31 Jul 2002 23:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318591AbSHADVp>; Wed, 31 Jul 2002 23:21:45 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:32787 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318589AbSHADVo>;
	Wed, 31 Jul 2002 23:21:44 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208010325.g713PAA340197@saturn.cs.uml.edu>
Subject: Re: [2.6] The List, pass #2
To: roland@topspin.com (Roland Dreier)
Date: Wed, 31 Jul 2002 23:25:10 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <52vg6vwbrw.fsf@topspin.com> from "Roland Dreier" at Jul 31, 2002 07:30:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier writes:
> >>>>> "Albert" == Albert D Cahalan <acahalan@cs.uml.edu> writes:
B
>     Guillaume> Definitely 2.7:
>     Guillaume> o InfiniBand support
> 
>     Albert> Why?
> 
>     Albert> Sure, one could get fancy, but just running SCSI or IP
>     Albert> over InfiniBand can't be that complicated... hmmm?
> 
> Look at http://infiniband.sf.net to see all the infrastructure
> required just to get to the point of being able to start to write an
> IP-over-IB driver.

As I said, "one could get fancy", thus missing the 2.6.xx kernel.
It's pretty obvious that you could do SCSI and IP with much less
code. What's with the "HCA DDK" anyway, UDI reborn? I see all sorts
of layers for IPC and what looks like VI/VIA, etc.

Ditch the lofty goals, and you might make the 2.6.xx kernel.
You can stick to being a FireWire alternative for now.

