Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSFJON2>; Mon, 10 Jun 2002 10:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSFJOMI>; Mon, 10 Jun 2002 10:12:08 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:32169 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315414AbSFJOLL>; Mon, 10 Jun 2002 10:11:11 -0400
Date: Mon, 10 Jun 2002 08:10:45 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D045B85.16136535@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0206100808180.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, Helge Hafting wrote:
> ls /dev/net
> eth0 eth1 eth2 ippp0

What is it worth? You have a few more files which you can't do anything 
with, and ifconfig output is much more greppable etc.

I remember these network devices from Solaris. There wasn't any good about 
them IIRC, the only sane way of working with them was to work around them, 
i.e. ignoring. Do you want a /dev/ignoreme directory?

We shouldn't introduce to ignore.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

