Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131390AbQLMOLj>; Wed, 13 Dec 2000 09:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131395AbQLMOL3>; Wed, 13 Dec 2000 09:11:29 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:49544 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131390AbQLMOLM>; Wed, 13 Dec 2000 09:11:12 -0500
Date: Wed, 13 Dec 2000 13:44:33 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Nils Philippsen <nils@fht-esslingen.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio - bad latency 
In-Reply-To: <Pine.LNX.4.30.0012131200050.28736-100000@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.30.0012131343080.1326-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Nils Philippsen wrote:

> Same here. Kernel is test12-pre8 and board is an Epox 8KTA2 (VIA KT133
> chipset). The funny thing is that audio itself doesnt get blocked, just XMMS'
> GUI.
>

it seems to happen across the board, ie whenever sound is being
played all apps that are holding any /dev/sound/ devices open become
unresponive. xmms, asmixer, mpg123, esd, etc.. etc..

> Nils
>

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Marvelous!  The super-user's going to boot me!
What a finely tuned response to the situation!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
