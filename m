Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274813AbTGaPdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270143AbTGaPbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:31:55 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:60599 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S272516AbTGaPaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:30:19 -0400
Message-ID: <1059665595.3f2936bb2d3a7@horde.sandall.us>
Date: Thu, 31 Jul 2003 08:33:15 -0700
From: Eric Sandall <eric@sandall.us>
To: Dirk Huste <dirkhuste@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Majordomo results: <no subject>
References: <200307311058.h6VAwfQ29574@mailgate5.cinetic.de>
In-Reply-To: <200307311058.h6VAwfQ29574@mailgate5.cinetic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scrive Dirk Huste <dirkhuste@web.de>:
> don't want to disturbe ... maybe i didn't get the right mailing list, but
> general sounds good ....
> 
> today i tried to compile a newer kernel version ... i thought i made anything
> right so far ... but things aren't always as easy as they seem to be,
> especially for a newbie ... 
> 
> configured kernel, created bzImage, modules ... installed them in  the
> correct paths ... configured lilo.conf and executed lilo ...
> 
> as result first "anything" works fine, while reboot, until lilo tries to load
> the new kernel:
> 
> Loading kernelxyz .... -> black screen: but the laptop ( gericom
> webshocks,with mini - pci - bussytem ) still seems to work in the background
> ...
> 
> still i would be glad if anybody, who knows what went wrong, could take some
> time and give me a hind about troubleshooting
> 
> THX  DK :)

Check out this page: 
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt

It has the fix for your problem.

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

