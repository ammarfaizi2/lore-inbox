Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268965AbUIMU0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268965AbUIMU0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUIMU0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:26:02 -0400
Received: from mta01.mail.tds.net ([216.170.230.81]:13276 "EHLO
	mta01.mail.tds.net") by vger.kernel.org with ESMTP id S268929AbUIMUXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:23:47 -0400
Date: Mon, 13 Sep 2004 15:26:35 -0500 (CDT)
From: David Lloyd <dmlloyd@tds.net>
To: SashaK <sashak@smlink.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  
 patch)
In-Reply-To: <20040912011128.031f804a@localhost>
Message-ID: <Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se> <20040912011128.031f804a@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, SashaK wrote:

> On Sat, 11 Sep 2004 20:50:58 +0200 (MEST)
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
>> No, I meant the 'slamr' kernel driver module, which is
>> built from a big binary-only library (amrlibs.o) and
>> a small amount of kernel glue source code. As long as
>> amrlibs.o is distributed only as a 32-bit x86 binary,
>> I won't be able to use it with a 64-bit amd64 kernel.
>
> This is exactly that was discussed - 'slamr' is going to be replaced by 
> ALSA drivers. I don't know which modem you have, but recent ALSA driver 
> (CVS version) already supports ICH, SiS, NForce (snd-intel8x0m), ATI IXP 
> (snd-atiixp-modem) and VIA (snd-via82xx-modem) AC97 modems.

Are these all motherboard-chipset modems, or is there such a thing as an 
AC97-based PCI modem card?

- D
