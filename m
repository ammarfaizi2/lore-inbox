Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSGNQ7I>; Sun, 14 Jul 2002 12:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSGNQ7I>; Sun, 14 Jul 2002 12:59:08 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:15241 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316935AbSGNQ7H>; Sun, 14 Jul 2002 12:59:07 -0400
Date: Sun, 14 Jul 2002 11:01:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Sandy Harris <pashley@storm.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
In-Reply-To: <3D3187E6.426BB595@storm.ca>
Message-ID: <Pine.LNX.4.44.0207141101120.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 14 Jul 2002, Sandy Harris wrote:
> Use two machines, both set to put boot messages on a serial console and
> connected so that when either reboots, the other is used as console. Do
> your sound in userspace (which I agree is where it belongs). Now as long
> as you don't reboot both at once (use a UPS!), you have sound for boot
> messages.

One might set up an embedded device reading out console to do that.

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

