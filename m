Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSCMWlp>; Wed, 13 Mar 2002 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311422AbSCMWlf>; Wed, 13 Mar 2002 17:41:35 -0500
Received: from p0178.as-l043.contactel.cz ([194.108.242.178]:31470 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S311423AbSCMWlY>; Wed, 13 Mar 2002 17:41:24 -0500
To: linux-kernel@vger.kernel.org
Subject: HP Omnibook 6000, reboot working?
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
Mail-Copies-To: never
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Wed, 13 Mar 2002 23:43:59 +0100
Message-ID: <m3u1rk9jgw.fsf@Janik.cz>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

anyone here with HP Omnibook 6000 successfully rebooting? I do have this
beast and after issuing /sbin/reboot, the machine is halted with the LCD
almost blank (you can see what was there a moment before, but it is almost
black), CD LED blinking and waiting for me to hold the poweroff button for
about 5 seconds? No command parameters (like reboot=bios or warm or cold or
whatever) helped. It happened in the past and it still happens with
2.4.18-4GB.

The same problem is mentioned here:
http://www.ima.umn.edu/~arnold/omnibook6000-linux.html

Machine can poweroff, but not reboot. APM works. I do not know if it is
connected with PCMCIA as that page says...

Do you know?
-- 
Pavel Janík

The default configuration of NNTP is not affected by the vulnerability, as
no newsgroups are configured by default.
                  -- Microsoft Product Security about memleak in NNTP server
