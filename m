Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316463AbSEZXLS>; Sun, 26 May 2002 19:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316464AbSEZXLR>; Sun, 26 May 2002 19:11:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56079
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316463AbSEZXLP>; Sun, 26 May 2002 19:11:15 -0400
Date: Sun, 26 May 2002 16:08:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
In-Reply-To: <20020526130547.A16548@ucw.cz>
Message-ID: <Pine.LNX.4.10.10205261551320.3010-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, I see.  So if I were to go back to ARTOP to request a copy of your
signed NDA to develop this driver, they would provide me the legal records
showing you were given all the documents neccessary to write a proper
driver.  This is very interesting concept.  You could not have derived a
driver without using my Copyrighted GPL material.  So you have illegally
removed Copyrights, renamed the operations, and called it your own.

Nice ... But it still makes you plagirist, and this is what I have always
knew about you.  Maybe this is cool in the general Linux community,
however, I will be asking for a legal brief from FSF.  Since you were only
permitted to modify the file and add your copyright to the changes if
appropriate.

All of the original code described how to make the hardware operate.  If
your code makes the hardware operate, then it uses material copyrighted 
and owned by me.

I suggest you think real hard and long about your decisions to go about
calling derived works from stolen/deleted Copyrights. 

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 26 May 2002, Vojtech Pavlik wrote:

> On Fri, May 24, 2002 at 10:07:36PM -0700, Andre Hedrick wrote:
> > 
> > Where do you get off delete copyrights?
> > GPL permits changing it does not give you the right to steal, lie, cheat,
> > defraud, other peoples work.  However I should not expect anything of
> > honor from a person of your high morals.  I know you want to rewrite the
> > past to make it so I and other never existed, but you are pathetic.
> 
> I don't delete copyrights, where applicable. However, in this case, none
> of the original code stayed, not a single line - I first wrote a spec
> based on the old driver and then wrote a new driver from scratch based
> on that spec. So, you really don't have a copyright on the new Artop
> driver, sorry.
> 
> > On Fri, 24 May 2002, Vojtech Pavlik wrote:
> > 
> > > On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Hi!
> > > > 
> > > > I have a very quick look over patch/driver... looks quite ok...
> > > > 
> > > > But it doesn't support multiple controllers. We should add 'unsigned
> > > > long private' to 'ata_channel struct' and store index in the chipset
> > > > table there.
> > > > You can remove duplicate entries from module data table.
> > > > 
> > > > BTW: please don't touch pdc202xx.c I am playing with it...
> > > 
> > > Here is a new patch. Martin: This one should be OK for inclusion now.
> > > Bartlomiej: Please check it anyway.
> > > 
> > > -- 
> > > Vojtech Pavlik
> > > SuSE Labs
> > > 
> > 
> > Andre Hedrick
> > LAD Storage Consulting Group
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> 

