Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSEYFJs>; Sat, 25 May 2002 01:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEYFJr>; Sat, 25 May 2002 01:09:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8206 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313563AbSEYFJr>; Sat, 25 May 2002 01:09:47 -0400
Date: Fri, 24 May 2002 22:07:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
In-Reply-To: <20020524172910.A17984@ucw.cz>
Message-ID: <Pine.LNX.4.10.10205242204360.31297-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where do you get off delete copyrights?
GPL permits changing it does not give you the right to steal, lie, cheat,
defraud, other peoples work.  However I should not expect anything of
honor from a person of your high morals.  I know you want to rewrite the
past to make it so I and other never existed, but you are pathetic.

On Fri, 24 May 2002, Vojtech Pavlik wrote:

> On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Hi!
> > 
> > I have a very quick look over patch/driver... looks quite ok...
> > 
> > But it doesn't support multiple controllers. We should add 'unsigned
> > long private' to 'ata_channel struct' and store index in the chipset
> > table there.
> > You can remove duplicate entries from module data table.
> > 
> > BTW: please don't touch pdc202xx.c I am playing with it...
> 
> Here is a new patch. Martin: This one should be OK for inclusion now.
> Bartlomiej: Please check it anyway.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> 

Andre Hedrick
LAD Storage Consulting Group

