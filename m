Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSGVKUZ>; Mon, 22 Jul 2002 06:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSGVKUZ>; Mon, 22 Jul 2002 06:20:25 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:41542 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S316621AbSGVKUY>; Mon, 22 Jul 2002 06:20:24 -0400
Date: Mon, 22 Jul 2002 04:23:29 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Thunder from the hill <thunder@ngforever.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <Pine.LNX.4.30.0207220952300.614-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44.0207220422390.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Szakacsits Szabolcs wrote:
> Potentially you _will_ lose data in swapoff case. Kernel could know
> when it's save to do but no way for admin to calculate.

The difference is between you will definitely loose data and you will 
potentially loose data.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

