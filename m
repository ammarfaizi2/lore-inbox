Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbSLSBCB>; Wed, 18 Dec 2002 20:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbSLSBCB>; Wed, 18 Dec 2002 20:02:01 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:32131 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267473AbSLSBCA>; Wed, 18 Dec 2002 20:02:00 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 18 Dec 2002 17:08:45 -0800
Message-Id: <200212190108.RAA03649@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>I'm waiting for the kernel bugzilla to become useful - currently the
>record for me has been:
>
>3 bugs total
>3 bugs for serial code for drivers I don't maintain, reassigned to mbligh.
>
>This means I write (choose one):
>
>1. non-buggy code (highly unlikely)
>2. code no one tests
>3. code people do test but report via other means (eg, email, irc)
>
>If it's (3), which it seems to be, it means that bugzilla is failing to
>do its job properly, which is most unfortunate.

	I don't currently use bugzilla (just due to inertia), but the
whole world doesn't have to switch to something overnight in order for
that facility to end up saving more time and resources than it has
cost.  Adoption can grow gradually, and it's probably easier to work
out bugs (in bugzilla) and improvements that way anyhow.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
