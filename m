Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317682AbSGJXoK>; Wed, 10 Jul 2002 19:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317683AbSGJXoJ>; Wed, 10 Jul 2002 19:44:09 -0400
Received: from pD952AE71.dip.t-dialin.net ([217.82.174.113]:63875 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317682AbSGJXoI>; Wed, 10 Jul 2002 19:44:08 -0400
Date: Wed, 10 Jul 2002 17:45:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Pavel Machek <pavel@ucw.cz>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [OT] /proc/cpuinfo output from some arch
In-Reply-To: <20020711003743.B25089@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207101744040.5067-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Russell King wrote:
> As far as SMP systems and cpufreq is concerned, we're going to have
> a /proc/sys/cpu/all/ as well - you can't control the clock rate of
> each cpu independently on such systems (otherwise they wouldn't be
> very symetric.)

Yes, asymmetric multiprocessing is a much more diffcult field, but 
it's not currently an issue to us. (Well, we had this issue long ago, but 
the SMP approach won, because even though it's uncool, it's still easier 
to handle. Maybe AMP will return one day...)

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

