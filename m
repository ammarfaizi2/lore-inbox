Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWBJLzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWBJLzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBJLzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:55:47 -0500
Received: from mail.gmx.de ([213.165.64.21]:65240 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751090AbWBJLzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:55:46 -0500
X-Authenticated: #428038
Date: Fri, 10 Feb 2006 12:55:42 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210115542.GA22337@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mj@ucw.cz, linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210114930.GC2750@DervishD>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD schrieb am 2006-02-10:

>     Hi Joerg :)
> 
>  * Joerg Schilling <schilling@fokus.fraunhofer.de> dixit:
> > Martin Mares <mj@ucw.cz> wrote:
> > > > This is why the mapping engine is in the Linux adoption part of
> > > > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > > > stable b,t,l address.
> > >
> > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> > 
> > Dou you like to verify that you have no clue on SCSI?
> 
>     My system is clueless, too! If I write a CD before plugging my
> USB storage device, my CD writer is on 0,0,0. If I plug my USB
> storage device *before* doing any access, my cdwriter is on 1,0,0.
> Pretty stable.

Thanks for answering the question I directed towards Jörg, which proves
Martin Mares's point that b,t,l is not stable.

I think, Martin, too deserves Jörg's apology, and Jörg shouldn't only be
more respectful, but listen to those who know their system better than
he does. (Of course this'll turn into a flame feast how stupid Linux
is.)

-- 
Matthias Andree
