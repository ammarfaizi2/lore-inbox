Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWGKQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWGKQcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWGKQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:32:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53656 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750851AbWGKQcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:32:22 -0400
Date: Tue, 11 Jul 2006 18:32:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Uwe Bugla <uwe.bugla@gmx.de>
cc: john stultz <johnstul@us.ibm.com>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: patch for timer.c
In-Reply-To: <20060711151932.19310@gmx.net>
Message-ID: <Pine.LNX.4.64.0607111830270.12900@scrub.home>
References: <20060711151932.19310@gmx.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-1847764240-1152635522=:12900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-1847764240-1152635522=:12900
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 11 Jul 2006, Uwe Bugla wrote:

> BUT: This is a =E2=80=9EPentium-4-only=E2=80=9C solution. On my file serv=
er, which is a Pentium 3 machine, the kernel stops booting and hangs the ma=
chine, no matter if I use framebuffer console with =E2=80=9Evga=3D791=E2=80=
=9C or not.
> Would you please try to find a fix for every architecture at any speed?

Where does it hang? Could you also check with SysRq+P or Alt+ScrollLock=20
where it hangs?

bye, Roman
---1463811837-1847764240-1152635522=:12900--
