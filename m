Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSHYNkI>; Sun, 25 Aug 2002 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSHYNkH>; Sun, 25 Aug 2002 09:40:07 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:34820 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317373AbSHYNkH>; Sun, 25 Aug 2002 09:40:07 -0400
Date: Sun, 25 Aug 2002 15:44:19 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020825134419.GC1529@louise.pinerecords.com>
References: <Pine.LNX.4.44.0208250618470.3234-100000@hawkeye.luckynet.adm> <6ubs7rm8gn.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ubs7rm8gn.fsf@zork.zork.net>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 4:20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi,
> >
> > On Sun, 25 Aug 2002, Geert Uytterhoeven wrote:
> >> "80-conductor cable not detected; limiting bus speed to UDMA2."
> >
> > ...or less...
> 
> "limiting maximum bus speed", then.

NO. the real info is "you can't get past UDMA2 w/o 80pin cables."
What sense would it make if the kernel printed the discussed warning
on chips that couldn't do better than that, anyway?

And s/bus/channel/.

T.
