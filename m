Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263912AbTCVWRB>; Sat, 22 Mar 2003 17:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263915AbTCVWRB>; Sat, 22 Mar 2003 17:17:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263912AbTCVWQw>;
	Sat, 22 Mar 2003 17:16:52 -0500
Date: Fri, 21 Mar 2003 22:17:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030321211708.GC12211@zaurus.ucw.cz>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com> <1047923841.1600.3.camel@laptop.fenrus.com> <20030317182040.GA2145@louise.pinerecords.com> <20030317182709.GA27116@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317182709.GA27116@gtf.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> > or 2.4.20.1 with only the critical stuff applied?
> 
> There shouldn't be a huge need to rush 2.4.21 as-is, really.  If you
> want an immediate update, get the fix from your vendor.

Many people are using self-compiled
kernels and it would be better to have
2.4.21 out than having each person
apply slightly different patch...

> Plus, it's a local root hole, and there are still tons of those left
> out there to squash.

Really? Care to name a few?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

