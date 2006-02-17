Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWBQKuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWBQKuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 05:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWBQKuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 05:50:55 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:6352 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750824AbWBQKuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 05:50:54 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 17 Feb 2006 11:49:14 +0100
To: schilling@fokus.fraunhofer.de, froese@gmx.de
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F5AA2A.nail2VC71UI32@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr>
 <43F1F196.nailMWZE1HZK5@burner>
 <200602141710.37869.dhazelton@enter.net>
 <43F4652F.nail20W57J1QB@burner>
 <20060216115204.GA8713@merlin.emma.line.org>
 <43F4BF26.nail2KA210T4X@burner> <20060216202649.28dec1fe.froese@gmx.de>
In-Reply-To: <20060216202649.28dec1fe.froese@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig <froese@gmx.de> wrote:

> Joerg Schilling wrote:
> >
> > Matthias Andree <matthias.andree@gmx.de> wrote:
> > 
> > > > I usually fix real bugs immediately after I know them.
> > >
> > > "Usually" is the key here. Sometimes, you refuse to fix real bugs
> > > forever even if you're made aware of them, and rather shift the blame
> > > on somebody else.
> > 
> > Show me a single real bug that I did not fix.
>
> Well, the kill(getppid(), SIG_INT)s in cdda2wav still cause system
> reboots when run as root.

Isn't this unfair?

Heiko did not work on cdda2wav since ~ 2.5 years.

You may have luck in the future as I received the SCCS history for cdda2wav
3 days ago, but there are other more important things to do first......

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
