Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSLVWgZ>; Sun, 22 Dec 2002 17:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSLVWgZ>; Sun, 22 Dec 2002 17:36:25 -0500
Received: from p0027.as-l043.contactel.cz ([194.108.242.27]:35569 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S265242AbSLVWgY> convert rfc822-to-8bit; Sun, 22 Dec 2002 17:36:24 -0500
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport_serial link order bug, NetMos support
References: <E18OxWK-0004w8-00@alf.amelek.gda.pl>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
In-Reply-To: <E18OxWK-0004w8-00@alf.amelek.gda.pl> (Marek Michalkiewicz's
 message of "Thu, 19 Dec 2002 11:03:12 +0100 (CET)")
Message-ID: <m3smwpfzaf.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
Date: Sun, 22 Dec 2002 23:46:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marek Michalkiewicz <marekm@amelek.gda.pl>
   Date: Thu, 19 Dec 2002 11:03:12 +0100 (CET)

Hi Marek,

   > I've been trying (for quite a long time now, starting around the
   > time when 2.4.19 was released) to submit the following patches into
   > the 2.4.x kernel:

so why don't you send them to Marcelo?

   > http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/01_netmos

[...]

   > The second patch adds support for NetMos PCI I/O cards, based on
   > a >1 year old 2.5.x patch by Tim Waugh.  I've been using a few
   > NM9835-based cards in production use, no problems so far (in 3
   > machines, one of them is my server with two permanent 115.2k PPP
   > connections, which have seen quite a few gigabytes of traffic).

We use this patch in a production use here too. Only direct serial traffic
with miscellaneous devices though but without problems so far.

   > Please, I would really appreciate to see these patches in 2.4.21.

+1
-- 
Pavel Janík

printk("??? No FDIV bug? Lucky you...\n");
                  -- 2.2.16 include/asm-i386/bugs.h
