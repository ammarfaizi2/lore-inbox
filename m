Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSFCRsr>; Mon, 3 Jun 2002 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSFCRsq>; Mon, 3 Jun 2002 13:48:46 -0400
Received: from pD952AF1C.dip.t-dialin.net ([217.82.175.28]:58499 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317439AbSFCRsp>; Mon, 3 Jun 2002 13:48:45 -0400
Date: Mon, 3 Jun 2002 11:48:42 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Martin.Knoblauch" <Martin.Knoblauch@teraport.de>
cc: pwaechtler@loewe-komp.de, <linux-kernel@vger.kernel.org>
Subject: Re: If you want kbuild 2.5, tell Linus
In-Reply-To: <200206031933.50389.Martin.Knoblauch@teraport.de>
Message-ID: <Pine.LNX.4.44.0206031143400.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 3 Jun 2002, Martin.Knoblauch wrote:
>  now my/the questions are:
> 
> - is what Kai is doing really leading to kbuild2.5

Not necessarily (Yet, it doesn't. It's just a plug of what was _indeed_ 
corrected directly the like in kbuild-2.5.) But yet I'm confident we'll 
get that done, but we all (even Kai) will have to change our attitudes. 
However, I don't have prejudices for Kai, and I will try my best to get my 
work done.

> - how man iterations will it take, will it be ready for 2.6 (whenenvwer 
> that is).

If it goes on the like it did for now, you'd better wait for linux-2.8. I 
don't think it will get in like this.

> - at what point will the kbuild-users have to learn new tricks, where is 
> the point of no-return?

The moment we merge Makefile-2.5 and Makefile, discarding compatibility 
targets.

However, try my linux-2.5.20-ct1, scheduled for somewhen until Wednesday. 
You can get a clear insight on some things such as kbuild-2.5 then.

> Martin

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

