Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSGILFe>; Tue, 9 Jul 2002 07:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSGILFd>; Tue, 9 Jul 2002 07:05:33 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:4574 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S313743AbSGILFc>; Tue, 9 Jul 2002 07:05:32 -0400
Date: Tue, 9 Jul 2002 05:08:06 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Neukum <oliver@neukum.name>
cc: Thunder from the hill <thunder@ngforever.de>,
       Keith Owens <kaos@ocs.com.au>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Driverfs updates
In-Reply-To: <200207091030.17096.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44.0207090502510.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, Oliver Neukum wrote:
> -It is slow.

I wouldn't call it any fast when I think about the idea that 31 of my CPUs 
on Hawkeye shall be stopped because I unload a module. Sometimes at high 
noon my server (Hawkeye) can hardly keep up all the traffic. Just imagine 
a module would be unloaded then! That's the problem I'm having with it.

What should make a lock for parts of the kernel slower than a lock for 
the _whole_ kernel?

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

