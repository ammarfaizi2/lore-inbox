Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSGSCFf>; Thu, 18 Jul 2002 22:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318448AbSGSCFf>; Thu, 18 Jul 2002 22:05:35 -0400
Received: from pD9E23646.dip.t-dialin.net ([217.226.54.70]:10368 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318447AbSGSCFe>; Thu, 18 Jul 2002 22:05:34 -0400
Date: Thu, 18 Jul 2002 20:08:17 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: David Wagner <daw@mozart.cs.berkeley.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: more thoughts on a new jail() system call
In-Reply-To: <ah7m2r$3cr$1@abraham.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.44.0207182007090.3525-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19 Jul 2002, David Wagner wrote:
> >sys_ioctl) J - disallowed, but perhaps if devices recognize jails and
> >filter commands based on that... 

I think it's quite hard for any type of network application to work well 
without TIOCINQ.

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

