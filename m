Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSGHQCq>; Mon, 8 Jul 2002 12:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSGHQCp>; Mon, 8 Jul 2002 12:02:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5590 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316043AbSGHQCo>; Mon, 8 Jul 2002 12:02:44 -0400
Date: Mon, 8 Jul 2002 18:05:11 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE, util-linux
In-Reply-To: <UTC200207081502.g68F2I701471.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0207081802001.28633-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't run vanilla 2.5.25, it has only IDE-93...

On Mon, 8 Jul 2002 Andries.Brouwer@cwi.nl wrote:

> Yesterday util-linux 2.11t was released.
> As always, comments are welcome.
>
> Wanted to continue some usb-storage work on 2.5 and
> recklessly booted 2.5.25. It survived for several hours,
> then deadlocked. Two filesystems turned out to be corrupted.
> Wouldn't mind if the rock solid 2.4 handling of HPT366
> was carefully copied to 2.5, that today quickly causes
> corruption and quickly deadlocks or crashes.
> [Yes, these are independent bugs. The fact that the current
> IDE code writes to random disk sectors is much more annoying
> than the fact that it crashes and deadlocks. This random
> writing is observed only on disks on the HPT366 card.]
>
> Andries

