Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314694AbSELCqF>; Sat, 11 May 2002 22:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315165AbSELCqF>; Sat, 11 May 2002 22:46:05 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28224 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314694AbSELCqE>; Sat, 11 May 2002 22:46:04 -0400
Date: Sat, 11 May 2002 22:46:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205120246.g4C2k4t04510@devserv.devel.redhat.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <mailman.1021067221.3300.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Don't forget 
>>that with 64 bit PCI that the limit of the bus has been raised, and with 
>>impending technologies like Infiniband and Hypertransport that limit 
>>will be raised again.
> 
> If people are interesting in discussing ideas on how InfiniBand 
> networking (sockets direct (SDP) and IP over InfiniBand) should be/could 
> be implemented and you are planning on attending the Linux Symposium
> in Ottawa in June, there is an InfiniBand BOF session where we could 
> discuss and exchange ideas on this topic. 

The more people, the merrier, but I am afraid that may subvert
the BOF. The problem is that nobody showed any convincing
proof that TOE actually works with benchmarks, let alone
in the real life. It was all a pretty groundless speculation so far.
I was on a conf call a week ago, where a guy said: "We implemented
TOE in the NT stack and achieved 100% speed-up", and I was like
"huh? and it tells me what? That NT stack was crap to begin with?"
I would like to keep the BOF on practical topics of Infiniband
implementation in Linux by any means necessary. TOE people
are welcome to come back when they have something working,
and when we know how fast the regular IP over Infiniband can go.

-- Pete
