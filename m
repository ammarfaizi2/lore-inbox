Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbTBCTKT>; Mon, 3 Feb 2003 14:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTBCTKT>; Mon, 3 Feb 2003 14:10:19 -0500
Received: from [81.2.122.30] ([81.2.122.30]:4614 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267011AbTBCTKL>;
	Mon, 3 Feb 2003 14:10:11 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302031920.h13JKZZd001140@darkstar.example.net>
Subject: Re: CPU throttling??
To: martin@martin.mh57.de (Martin Hermanowski)
Date: Mon, 3 Feb 2003 19:20:34 +0000 (GMT)
Cc: Valdis.Kletnieks@vt.edu, assembly@gofree.indigo.ie,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030203190920.GO1472@martin.mh57.de> from "Martin Hermanowski" at Feb 03, 2003 08:09:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Incidently, Linux has always halted the processor, rather than spun in
> > > an idle loop, which saves power.
> >
> > It's conceivable that a CPU halted at 1.2Gz takes less power than one
> > at 1.6Gz - anybody have any actual data on this?  Alternately phrased,
> > does CPU throttling save power over and above what the halt does?
> 
> If I slow down my 1GHz CPU to 732MHz, I get 15min more (195min total).
> So it is not much, but noticeable.

Does anybody have any data on frequency throttling on non-X86
architectures?

John.
