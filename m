Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSJ3WPL>; Wed, 30 Oct 2002 17:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbSJ3WPL>; Wed, 30 Oct 2002 17:15:11 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:31752 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S264939AbSJ3WPL>; Wed, 30 Oct 2002 17:15:11 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200210302213.g9UMDuNX012570@wildsau.idv.uni.linz.at>
Subject: Re: VIA EPIA problem
In-Reply-To: <1035559918.13032.29.camel@irongate.swansea.linux.org.uk> from Alan Cox at "Oct 25, 2 04:31:58 pm"
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 30 Oct 2002 23:13:55 +0100 (MET)
Cc: sergeyssv@mail.ru, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-10-25 at 16:00, Serge wrote:
> > Mainboard VIA EPIA mini-ITX with VIA C3 800 Mhz or 500 Mhz
> > 
> > I faced with strange problem connected to this mainboard.
> > 
> > Kernel crashed when attempt to configrue net interface. 
> 
> Are you using an early cubid 2677 case or another very small power
> supply. There are known problems with the ethernet if you are under
> current
> 

please see my posts to lkml some months (2, 3?) ago. there's a problem
which stops the via-rhine. a small two-line patch will solve the problem.
search in the archives for "via" and "path", because I made a typo
and wrote "path" instead of "patch".

hth,
herp

