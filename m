Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSGLWME>; Fri, 12 Jul 2002 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318029AbSGLWMD>; Fri, 12 Jul 2002 18:12:03 -0400
Received: from pD952ACB5.dip.t-dialin.net ([217.82.172.181]:23687 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318028AbSGLWMA>; Fri, 12 Jul 2002 18:12:00 -0400
Date: Fri, 12 Jul 2002 16:14:23 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "David S. Miller" <davem@redhat.com>
cc: thunder@ngforever.de, <linux-kernel@vger.kernel.org>,
       <zippel@linux-m68k.org>, <ultralinux@vger.kernel.org>
Subject: Re: L1_CACHE_SHIFT on sparc64
In-Reply-To: <20020712.145524.91314408.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207121613220.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, David S. Miller wrote:
> Right.  But who needs L1_CACHE_SHIFT?

fs/dquot.c uses it.

> Nothing generic should reference it.  Did something get added to 2.5.x
> that needs it now?

Must have been 2.5, but not since 2.5.24.

> I wouldn't have noticed yet as I've been away for nearly half a month
> on vaction until a day or two ago.

Welcome back!

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

