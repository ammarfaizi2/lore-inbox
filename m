Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271992AbRH2PTg>; Wed, 29 Aug 2001 11:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271994AbRH2PT1>; Wed, 29 Aug 2001 11:19:27 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:53943 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S271992AbRH2PTJ>; Wed, 29 Aug 2001 11:19:09 -0400
Date: Wed, 29 Aug 2001 17:26:16 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Pascal Schmidt <pleasure.and.pain@web.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Can't compile HiSaX into 2.2.20pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0108291038500.18233-100000@chaos.tp1.ruhr-uni-bochum.de>
Message-ID: <Pine.LNX.4.33.0108291725530.819-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, Kai Germaschewski wrote:

> In drivers/isdn/hisax/config.c, remove the "static" in the line
> static void HiSax_setup(...)
Thanks, now it works.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

