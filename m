Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWBNSmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWBNSmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWBNSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:42:48 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:20233 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1030424AbWBNSmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:42:47 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 14 Feb 2006 13:42:10 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: trudheim@gmail.com, Valdis.Kletnieks@vt.edu, peter.read@gmail.com,
       mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214184210.GB4749@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	trudheim@gmail.com, Valdis.Kletnieks@vt.edu, peter.read@gmail.com,
	mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de,
	dhazelton@enter.net
References: <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com> <43F0AA83.nailKUS171HI4B@burner> <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com> <43F0B2BA.nailKUS1DNTEHA@burner> <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr> <43F0B5BE.nailMBX2SZNBE@burner> <200602131919.k1DJJF5G025923@turing-police.cc.vt.edu> <43F1C385.nailMWZ599SQ5@burner> <515e525f0602140501j1f9fbe14x8a3eef0bbf179035@mail.gmail.com> <43F209BB.nailMWZP1XY5P@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43F209BB.nailMWZP1XY5P@burner>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/06 05:47:55PM +0100, Joerg Schilling wrote:
> Anders Karlsson <trudheim@gmail.com> wrote:
> 
> > On 2/14/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > [snip]
> > > -       How does HAL allow one cdrecord instance to work
> > >         without being interrupted by HAL?
> >
> > Uuh, if the writer unit is plugged in via USB and HAL detects it going
> > away, as in getting disconnected from the system, don't you think it
> > would be a smart move for cdrecord to pay attention to such an alert?
> >
> > I am sure you can explain to me if there are overwhelming technical
> > reason to continue dumping data to a non-existant device.
> 
> It seems that you did not loisten to this discussion before, why doyou come in 
> now not knowing the topcis?
> 
> Try to get hand on the deleted bug entries on Debian and you will see how
> cdrecord is interrupted.
> 
> Jörg

Apparently you're the one not paying attention, the so-called bugs you were
talking about haven't been deleted and I even mentioned that I found them
in this 'discussion' days ago.

Jim.
