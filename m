Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTBQNxl>; Mon, 17 Feb 2003 08:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTBQNxl>; Mon, 17 Feb 2003 08:53:41 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:17388 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267121AbTBQNw7>; Mon, 17 Feb 2003 08:52:59 -0500
Date: Mon, 17 Feb 2003 15:02:49 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <20030217135505.GF6282@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.33.0302171458460.15439-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A patch for 2.4.20-pre7 (and maybe later) is at
> >   http://www.physik3.uni-rostock.de/tim/kernel/2.4/
>
> Some of the architectures appear to be untested. This fixes arm and
> beautifies m68k.
> ( At least, I hope so. I didn't test it either :)
>
> Tim, is the inline patch fine with you?

looks good. Thanks,

Tim

(actually all arches except i386 and alpha were untestet...)

