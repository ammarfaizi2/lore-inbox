Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbQLMORU>; Wed, 13 Dec 2000 09:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbQLMORL>; Wed, 13 Dec 2000 09:17:11 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:55944 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131495AbQLMOQ4>; Wed, 13 Dec 2000 09:16:56 -0500
Date: Wed, 13 Dec 2000 13:50:15 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Nils Philippsen <nils@fht-esslingen.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio - bad latency 
In-Reply-To: <Pine.LNX.4.30.0012131200050.28736-100000@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.30.0012131348500.1326-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Nils Philippsen wrote:

> Same here. Kernel is test12-pre8 and board is an Epox 8KTA2 (VIA KT133
> chipset). The funny thing is that audio itself doesnt get blocked, just XMMS'
> GUI.

same for me, the audio plays fine, but xmms is completely
unresponsive, as is the gnome mixer, as is asmixer. (ie everything to
do with esd or /dev/sound). soon as i SIGSTOP the playing app all the
other apps come back to life.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Parts that positively cannot be assembled in improper order will be.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
