Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317896AbSFNJTm>; Fri, 14 Jun 2002 05:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317895AbSFNJTl>; Fri, 14 Jun 2002 05:19:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19903 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317896AbSFNJTj>; Fri, 14 Jun 2002 05:19:39 -0400
Date: Fri, 14 Jun 2002 11:19:16 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <Pine.LNX.4.10.10206140155041.21513-100000@master.linux-ide.org>
Message-ID: <Pine.SOL.4.30.0206141116290.7074-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nice, with any luck pATA will be dead before 2.6 is released so people
> will not have to suffer data losses from overclocked drivers and main
> loops issuing "low-level format" command codes to the hardware at boot.

It wasn't sending "low-level format"...
It was bug in ide-scsi, and was fixed immediately by Martin...

--
Bartlomiej

