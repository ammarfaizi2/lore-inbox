Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSFRTLo>; Tue, 18 Jun 2002 15:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSFRTLm>; Tue, 18 Jun 2002 15:11:42 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:64998 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317559AbSFRTLi>; Tue, 18 Jun 2002 15:11:38 -0400
Date: Tue, 18 Jun 2002 20:43:51 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KO4i-0002xn-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206182040400.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

On Wed, 19 Jun 2002, Rusty Russell wrote:

> > Can you fix this or tell me what is the new equivalent of
> > cpu_online_map?
> 
> Well, I'm heading away from assumptions on the arch representations of
> online CPUs (which the NUMA guys need anyway).

Will there also be some sort of facility to determine which node a cpu is 
from, this would be quite handy in other areas.

Cheers,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

