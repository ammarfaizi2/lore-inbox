Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317881AbSGWBHx>; Mon, 22 Jul 2002 21:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGWBHx>; Mon, 22 Jul 2002 21:07:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2011 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317881AbSGWBHw>; Mon, 22 Jul 2002 21:07:52 -0400
Date: Tue, 23 Jul 2002 03:10:38 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thunder from the hill <thunder@ngforever.de>
cc: A Guy Called Tyketto <tyketto@wizard.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please DON'T run 2.5.27 with IDE!
In-Reply-To: <Pine.LNX.4.44.0207221857160.3241-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.SOL.4.30.0207230307110.22774-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Thunder from the hill wrote:

> Hi,
>
> On Mon, 22 Jul 2002, A Guy Called Tyketto wrote:
> > With this, I'm assuming 2.5.27 has IDE 100 in it, patched up from IDE
> > 99. Correct me if I'm wrong.

Hi,

You are wrong. ;-)
IDE patches are incremetnal, IDE 100 is incremental to IDE 99.
Both are in 2.5.27.

 > Introducing a bug in 99 doesn't mean it has to be fixed in 100. However,
> it might be. Martin, could you please tell us more about it?

It IS NOT. IDE 100 is a trivia patch indendation + initializers etc.

>
> BTW, where did we end up? We don't even know the current IDE state...
>
> 							Regards,
> 							Thunder
> --
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y-
> ------END GEEK CODE BLOCK------

