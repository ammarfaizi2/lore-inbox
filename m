Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSHHM0H>; Thu, 8 Aug 2002 08:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSHHM0H>; Thu, 8 Aug 2002 08:26:07 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57304 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317552AbSHHM0G>;
	Thu, 8 Aug 2002 08:26:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 8 Aug 2002 14:29:44 +0200 (MEST)
Message-Id: <UTC200208081229.g78CTiY21579.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, martin@dalecki.de
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Cc: Andries.Brouwer@cwi.nl, adam@yggdrasil.com, johninsd@san.rr.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its not a bug in lilo.

We disagree here.

> Its a bug in the new kernel.

We disagree again.

> Breaking backward compatibility arbitrarily is bad.

Of course.

> The kernel needs to know geometry anyway

Let me repeat: Geometry does not exist.
It is impossible to know something that does not exist.
I can boot seven different kernels on my present machine
and get seven different geometries for /dev/hda.
You see that even "backward compatibility" is a
dubious concept here. Compatibility with what?

Even the BIOS is not consistent, and different BIOS functions
report different geometries.

We have had layer upon layer of bandaids.
I think the time is long overdue to get rid of it all.

> for the folks who have force ide translation

Can you elaborate on what you mean by "force ide translation" ?

Andries
