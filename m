Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbSJDXHO>; Fri, 4 Oct 2002 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSJDXGt>; Fri, 4 Oct 2002 19:06:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24079 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261954AbSJDXGd>; Fri, 4 Oct 2002 19:06:33 -0400
Date: Fri, 4 Oct 2002 16:13:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (NUMA)
In-Reply-To: <512380000.1033770394@flay>
Message-ID: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Martin J. Bligh wrote:
> 
> When you say we have "some of" that (NuMA support) ... what else would you 
> like to see?

The main thing that I think is lacking is any relevance to any significant 
user base, thanks to lack of interesting hardware. So even if Linux itself 
was doing everything perfectly, as long as there is no wide hw base and 
users, it's all pretty much academic, the same way SMP was during the 
early 1.x days.

And I'm not trying to put you or any of the Linux NuMA work down here, I'm 
just saying that what makes it not important as a "3.0 feature" is just 
that deployment doesn't merit it yet.

			Linus

