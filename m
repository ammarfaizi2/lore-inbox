Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131796AbRAFQqC>; Sat, 6 Jan 2001 11:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRAFQpw>; Sat, 6 Jan 2001 11:45:52 -0500
Received: from hera.cwi.nl ([192.16.191.1]:13541 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131796AbRAFQpk>;
	Sat, 6 Jan 2001 11:45:40 -0500
Date: Sat, 6 Jan 2001 17:45:35 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101061645.RAA145723.aeb@texel.cwi.nl>
To: maillist@chello.nl, matthias.andree@stud.uni-dortmund.de
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not that simple.. The maxtor comes clipped,. but Linux can't kill the
> clip. So it sticks with 32 MB

> ibmsetmax.c does a software clip, but that bugs a bit. Sometimes even
> Linux doesn't see 61 GB, but only 32, sometimes the full capacity.

Please don't talk vague useless garbage.
There is no entity called "Linux". If you mean "the 2.4.0 kernel
boot messages report 61 GB, fdisk 2.9s sees 32 GB, fdisk 2.10r sees 61 GB"
then say so. If you mean something else, say what you mean.
Precisely, with versions and everything.

Since you have a Maxtor, my old setmax should suffice for you, it can kill
the clip, and there is no reason to use ibmsetmax.c, that is a version for
IBM disks. There should not be any need to use other machines.

If something changed for recent Maxtor disks, we would like to know,
but only reliable, detailed reports are of any use.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
