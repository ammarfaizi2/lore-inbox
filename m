Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSFBTQG>; Sun, 2 Jun 2002 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSFBTQF>; Sun, 2 Jun 2002 15:16:05 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:43728 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S312601AbSFBTQE>; Sun, 2 Jun 2002 15:16:04 -0400
Date: Sun, 2 Jun 2002 13:15:51 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Thunder from the hill <thunder@ngforever.de>,
        Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <Pine.LNX.4.44.0206021441510.671-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.44.0206021313230.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No matter if ya'll reply, but a few things to be mentioned:

On Sun, 2 Jun 2002, Ion Badulescu wrote:
> However, having both in the tree can mean only one of a few things:

5. the better will stay, the worse will be pulled from the tree.

> Also, don't say 'well you need the core to do this and that', it only shows 
> that you don't understand the core and you're treating it like a black box.
> Once you do understand it, you'll see there are many ways to break it up 
> feature-wise.

But other features require parts of the thing you call core which won't 
get in because they look silly without the stuff that is using it. Who 
needs a loose mdbm?

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

