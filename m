Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTKYTgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTKYTgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:36:14 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:7097 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S262767AbTKYTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:36:13 -0500
Message-ID: <1069788972.3fc3af2c16b8f@horde.sandall.us>
Date: Tue, 25 Nov 2003 11:36:12 -0800
From: Eric Sandall <eric@sandall.us>
To: linux-kernel@vger.kernel.org
Subject: Re: off: nvidia binary driver with 2.6-test10
References: <1069741003.3493.2.camel@zeus.city.tvnet.hu>
In-Reply-To: <1069741003.3493.2.camel@zeus.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sipos Ferenc <sferi@mail.tvnet.hu>:
> Hi!
> 
> Something has changed between 2.6-test9 and 2.6-test10, the nvidia
> driver for test3-mm3 won't run automatically, I have to reinstall each
> system restart. Does anybody have a patch? Thx.
> 
> Paco

Have you tried compiling the driver against -test10?

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

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
