Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271880AbRIDDfI>; Mon, 3 Sep 2001 23:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271885AbRIDDe6>; Mon, 3 Sep 2001 23:34:58 -0400
Received: from femail46.sdc1.sfba.home.com ([24.254.60.40]:55260 "EHLO
	femail46.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271880AbRIDDes>; Mon, 3 Sep 2001 23:34:48 -0400
Date: Mon, 3 Sep 2001 23:38:14 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Sound Blaster Live - OSS or Not?
In-Reply-To: <999557473.7696.1.camel@phantasy>
Message-ID: <Pine.LNX.4.33L2.0109032334580.28591-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2001, Robert Love wrote:

> On Mon, 2001-09-03 at 18:26, Thiago Vinhas de Moraes wrote:
> > > Use the alsa driver from www.alsa-project.org
> > Why isn't it on the kernel tree?
>
> Because ALSA is not in the kernel tree. ALSA is a completely different
> sound system from OSS, and ALSA is not in the tree. Many find ALSA
> superior, and suggest it replace OSS. ALSA may find its way into the
> tree during 2.5.
>
> Of note, I don't know why SBLive does not work w/o these drivers. SBLive
> in the kernel tree is very functional, and the OSS version should work
> fine (assuming the game works with OSS).
>
>

I'm also experiencing problems with Q3A and SB Live! It worked fine for
me before 2.4.9, but now with the "new" emu10k1 drivers it segfaults.

I already reported this earlier when 2.4.8-ac tree included the new
emu10k1 drivers but nothing came of it. Then Alan Cox reverted the drivers
and it worked fine. Now with 2.4.9 it segaults again.

I'll have to give the alsa drivers a try I guess.

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
Public key at http://www.geocities.com/gspencley/public_key.txt
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

