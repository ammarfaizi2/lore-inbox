Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSGHRIJ>; Mon, 8 Jul 2002 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSGHRII>; Mon, 8 Jul 2002 13:08:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64228 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317017AbSGHRIH>; Mon, 8 Jul 2002 13:08:07 -0400
Date: Mon, 8 Jul 2002 19:10:22 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE, util-linux
In-Reply-To: <UTC200207081650.g68GoJJ02428.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0207081900090.12042-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Jul 2002 Andries.Brouwer@cwi.nl wrote:

> >> recklessly booted 2.5.25. It survived for several hours,
> >> then deadlocked. Two filesystems turned out to be corrupted.
> >> Wouldn't mind if the rock solid 2.4 handling of HPT366
> >> was carefully copied to 2.5
>
> > Don't run vanilla 2.5.25, it has only IDE-93...
>
> Yes. Funny isn't it? Every few weeks the past two or three
> months I reported on the status of 2.5 on my hardware.
> Always the answer is: yes, we know, the current version is
> broken, wait for version N+1.

Really not funny and I'm not the guilty one here...

I have just started fixing 2.5 bugs and there is a lot of them...

> I hope you noticed the HPT366 part of my letter, and not
> only the deadlock part.

Yes.

Regards
--
Bartlomiej


