Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317303AbSFGREf>; Fri, 7 Jun 2002 13:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSFGREe>; Fri, 7 Jun 2002 13:04:34 -0400
Received: from p50886B5E.dip.t-dialin.net ([80.136.107.94]:15491 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317303AbSFGREe>; Fri, 7 Jun 2002 13:04:34 -0400
Date: Fri, 7 Jun 2002 11:04:26 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: jgarzik@mandrakesoft.com, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 tulip bogosities
In-Reply-To: <200206061624.SAA17598@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0206071103170.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Jun 2002, Mikael Pettersson wrote:
> Also note the obviously broken "eth%d" printk format string.

It's printk("%s: blah\n", dev->name);

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

