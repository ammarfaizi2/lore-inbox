Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317857AbSGVXeS>; Mon, 22 Jul 2002 19:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSGVXeR>; Mon, 22 Jul 2002 19:34:17 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:32738 "EHLO
	moutvdomng3.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317857AbSGVXeP>; Mon, 22 Jul 2002 19:34:15 -0400
Date: Mon, 22 Jul 2002 17:37:04 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul Larson <plars@austin.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <haveblue@us.ibm.com>
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
In-Reply-To: <1027383490.32299.94.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221735190.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23 Jul 2002, Alan Cox wrote:
> egcs-1.1.2 does have real problems with 2.5
> 
> 7.1 errata/7.2/7.3 gcc 2.96 appear quite happy

So what compiler could I use on my sparc64? IIRC, the current gcc versions 
failed to make up clean bytecode, and the older versions fail to deal with 
newer code...

I've seen the gcc 3.1 test report from Dave Miller, and I knew it could be 
nasty times if I try to get used to it...

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

