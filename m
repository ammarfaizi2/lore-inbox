Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbUATS7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUATS7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:59:49 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:55460 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S265687AbUATS7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:59:45 -0500
Message-ID: <1074625238.400d7ad6144e9@horde.sandall.us>
Date: Tue, 20 Jan 2004 11:00:38 -0800
From: Eric Sandall <eric@sandall.us>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
References: <1074532714.16759.4.camel@midux> <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org> <1074536486.5955.412.camel@castle.bigfiber.net> <200401201046.24172.hus@design-d.de>
In-Reply-To: <200401201046.24172.hus@design-d.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heinz Ulrich Stille <hus@design-d.de>:
> On Monday 19 January 2004 19:21, Travis Morgan wrote:
> > I have a soundblaster Live Value card. I can no longer control the
> 
> I also have a SB Live!, and it doesn't work with ALSA at all - the AC97
> codec doesn't load. I haven't taken the time to track it down as it does
> work just fine with OSS (under SMP at that).

My SBLive! has been working with ALSA since I first used it (0.9.6 or something)
on both 2.4 and 2.6 kernels.

Asus nForce2 board.
01:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
01:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

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
