Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTBETOR>; Wed, 5 Feb 2003 14:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTBETOR>; Wed, 5 Feb 2003 14:14:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:20996 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264681AbTBETOQ>;
	Wed, 5 Feb 2003 14:14:16 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302051924.h15JOi18000605@darkstar.example.net>
Subject: Re: gcc 2.95 vs 3.21 performance
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 5 Feb 2003 19:24:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b1rni4$3dr$1@penguin.transmeta.com> from "Linus Torvalds" at Feb 05, 2003 07:09:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >There is also tcc (http://fabrice.bellard.free.fr/tcc/)
> >It claims to support gcc-like inline assembler, appears to be much 
> >smaller and faster than gcc. Plus it is GPL so the liscense isn't a 
> >problem either.
> >Though, I am not really sure of the quality of code generated or of how 
> >mature it is.
> 
> tcc is interesting.  The code generation is pretty simplistic (read:
> trivially horrible for most things), but it sure is fast and small.  And
> judging by the changelog, Fabrice is trying to compile the kernel with
> it. 
> 
> For a lot of problems, small-and-fast is good.

Maybe otcc is a better choice, then?

http://fabrice.bellard.free.fr/otcc/

:-)

John.
