Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315441AbSELWPR>; Sun, 12 May 2002 18:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSELWPQ>; Sun, 12 May 2002 18:15:16 -0400
Received: from pD9E237A7.dip.t-dialin.net ([217.226.55.167]:42626 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315441AbSELWPQ>; Sun, 12 May 2002 18:15:16 -0400
Date: Sun, 12 May 2002 16:15:09 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Diego Calleja <DiegoCG@teleline.es>
cc: Becki Minich <bminich@earthlink.net>, <linux-kernel@vger.kernel.org>,
        <johnnyo@mindspring.com>
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <20020512234153.55d655d6.DiegoCG@teleline.es>
Message-ID: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 May 2002, Diego Calleja wrote:
> > attempt to access beyond end of device
> > 08:12: rw=0 want=268574776 limit=8747392
> 
> I'm not an expert, but this perhaps isn't a reiserfs problem.

Nope. It looks much more like the IDE problem Tomas Szepe addressed in 
"2.5.15 IDE possibly trying to scribble beyond end of device"

http://marc.theaimsgroup.com/?l=linux-kernel&m=102102901525874&w=2

Regards,
Thunder
-- 
Was it a black who passed anong in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.

