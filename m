Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282495AbRLOLJv>; Sat, 15 Dec 2001 06:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLOLJl>; Sat, 15 Dec 2001 06:09:41 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:29403 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S282418AbRLOLJb>;
	Sat, 15 Dec 2001 06:09:31 -0500
Date: Sat, 15 Dec 2001 12:09:28 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200112151109.MAA02201@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems downgrading from Kernel 2.4.8 to 2.2.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001 00:50:44 +0100, Matthias Andree wrote:
>> hda: lost interrupt
>
>That looks stranger. I'd suggest to try Andre's IDE patch from any
>kernel.org mirror, /pub/linux/kernel/people/hedrick, but it seems
>there's no 2.2.20 ide patch yet.

You can get my unofficial port of Hedrick's 2.2.19 IDE patch to 2.2.20
at http://www.csd.uu.se/~mikpe/linux/ide.2.2.20.05042001.patch.bz2

/Mikael
