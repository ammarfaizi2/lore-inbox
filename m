Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315910AbSFCX4t>; Mon, 3 Jun 2002 19:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFCX4s>; Mon, 3 Jun 2002 19:56:48 -0400
Received: from pD9E23450.dip.t-dialin.net ([217.226.52.80]:26508 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315910AbSFCX4s>; Mon, 3 Jun 2002 19:56:48 -0400
Date: Mon, 3 Jun 2002 17:56:29 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Scott Murray <scottm@somanetworks.com>
cc: Thunder from the hill <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [PATCH][2.5] Port opl3sa2 changes from 2.4
In-Reply-To: <Pine.LNX.4.33.0206031923540.5598-100000@rancor.yyz.somanetworks.com>
Message-ID: <Pine.LNX.4.44.0206031755510.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 3 Jun 2002, Scott Murray wrote:
> I gotta say, I'm a little lost as to why you're taking this upon yourself,
> considering that Zwane is for all intents and purposes the maintainer now
> instead of me, and he seems to be effectively pushing stuff into 2.5 via
> the Alan -> Marcelo -> Dave Jones -> Linus scheme.  I would really prefer
> that you let him submit a patch for this, as I'm pretty sure that the
> addition of the isapnp_change_resource calls will break the driver for
> anyone whose machine doesn't have DMA 0 available.

Because I considered to get it into the -ct1. But if you see it like this, 
I pull it.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

