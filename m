Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSFDNAL>; Tue, 4 Jun 2002 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSFDNAK>; Tue, 4 Jun 2002 09:00:10 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:4538 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316619AbSFDNAH>; Tue, 4 Jun 2002 09:00:07 -0400
Date: Tue, 4 Jun 2002 14:31:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Scott Murray <scottm@somanetworks.com>
Cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Port opl3sa2 changes from 2.4
In-Reply-To: <Pine.LNX.4.33.0206031846520.5598-100000@rancor.yyz.somanetworks.com>
Message-ID: <Pine.LNX.4.44.0206041423530.19645-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Mon, 3 Jun 2002, Scott Murray wrote:

> I think always blindly remapping the the DMA channels to 0 and 1 is a bad
> idea and will likely break things for some people.  It would be better if
> the core isapnp code could be made smarter, but a simple alternative would
> be to rework the opl3sa2 module parameter parsing to allow using the DMA
> parameters as an override when using PnP.

I'm working with Gerald in order to get a decent workaround in without 
messing with isapnp using your recommendation.

> PS: Zwane, any chance you want to update MAINTAINERS to "officially" take
>     over opl3sa2?

I sent a patch for that with a patch a while back, i'll double check.

Thanks,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		


