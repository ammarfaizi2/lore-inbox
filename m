Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbSIYILq>; Wed, 25 Sep 2002 04:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbSIYILq>; Wed, 25 Sep 2002 04:11:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:32522 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261939AbSIYILp>; Wed, 25 Sep 2002 04:11:45 -0400
Date: Wed, 25 Sep 2002 10:17:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Message-ID: <20020925081700.GA4778@atrey.karlin.mff.cuni.cz>
References: <3D8E8371.D2070D87@opersys.com> <20020922045907.C35@toy.ucw.cz> <3D90D388.746D0C0D@opersys.com> <20020924220607.GD1496@atrey.karlin.mff.cuni.cz> <3D90F3AC.84AFDE93@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D90F3AC.84AFDE93@opersys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You can't
> > run two copies of linux, because they would fight over memory; right?
> 
> Currently we can't, you're right. But I've already detailed how to do
> this in a paper I wrote last july on how to obtain Linux SMP clusters
> with as few modifications to the kernel as possible. The paper is
> available on the web:
> http://opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
> (If you stil can't access the web as said in the other email, I can
> send you a copy off-list if you want.)

Its okay now, thanx.

> > Do you have something that can run alongside linux?
> 
> Certainly. According to some reports it's already used in some commercial
> systems and, as today's RTAI announcement reads, it will be the basis
> for the next release of RTAI.

Ok. Good luck pushing it through linus ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
