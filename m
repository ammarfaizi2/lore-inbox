Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSGMR4n>; Sat, 13 Jul 2002 13:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGMR4n>; Sat, 13 Jul 2002 13:56:43 -0400
Received: from pD9E23254.dip.t-dialin.net ([217.226.50.84]:55169 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315276AbSGMR4m>; Sat, 13 Jul 2002 13:56:42 -0400
Date: Sat, 13 Jul 2002 11:59:31 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined references to "jiffies" on sparc64
In-Reply-To: <Pine.LNX.4.44.0207130933190.3331-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207131155300.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 Jul 2002, Thunder from the hill wrote:
> Using 2.5.25 with 
> <URL:ftp://luckynet.dynu.com/pub/linux/2.5.25-ct1/patch-2.5.25-ct1.bz2>, I 
> get lots of unsigned references to "jiffies" when compiling on sparc64. Do 
> jiffies have to be defined in some special location, apart from 
> linux/jiffies.h? I can't  find them on i386, either.

If you want to have a look at the code without patching, it's here:
<URL:http://luckynet.dynu.com/cgi-bin/cvsweb.cgi/thunder-2.5/>

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

