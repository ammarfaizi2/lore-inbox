Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135305AbRDLUFO>; Thu, 12 Apr 2001 16:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135306AbRDLUEy>; Thu, 12 Apr 2001 16:04:54 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:45712 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135305AbRDLUEw>; Thu, 12 Apr 2001 16:04:52 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 13:04:51 -0700
Message-Id: <200104122004.NAA00308@baldur.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks, but Andrey Panin did you one better -- he produced a patch which
>fixes up a good number of these.  You should follow lkml more closely :)

I missed that patch and have been unable to find it on google/dejanews.
However, my point is to provide an exhaustive list with sizes (and the tool
for generating it), to make it easier to spot and prioritize ones that
may have been missed.

Anyhow, thanks for the tip.  Perhaps I should run this program and
post results again on a subsequent kernel release (presumably
with Andrey's patch), although anyone else can run this program
just as easily.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
