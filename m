Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318367AbSGRVcH>; Thu, 18 Jul 2002 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318368AbSGRVcH>; Thu, 18 Jul 2002 17:32:07 -0400
Received: from pD952A86D.dip.t-dialin.net ([217.82.168.109]:23680 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318367AbSGRVcG>; Thu, 18 Jul 2002 17:32:06 -0400
Date: Thu, 18 Jul 2002 15:34:51 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2aa1
In-Reply-To: <Pine.LNX.4.44.0207181212180.21840-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0207181530390.3911-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jul 2002, Tobias Ringstrom wrote:
> Why are you not changing the EXTRAVERSION in your patch?  I would make it 
> much easier to diffrentiate between kernels.

I did that for me.

# uname -r
2.4.19-rc2-aa1
# 

It's working fine for some hours now. The EXTRAVERSION is the only thing 
that I changed, and -rc2-aa1 works just fine. But my bdflush seems - with 
the same values as from -rc1-aa2 - not to have 100% of the old efficiency 
any more.

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

