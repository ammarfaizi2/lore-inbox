Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280047AbRKIT7j>; Fri, 9 Nov 2001 14:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280056AbRKIT7a>; Fri, 9 Nov 2001 14:59:30 -0500
Received: from AMontpellier-201-1-6-99.abo.wanadoo.fr ([80.11.171.99]:14604
	"EHLO awak") by vger.kernel.org with ESMTP id <S280047AbRKIT7Q> convert rfc822-to-8bit;
	Fri, 9 Nov 2001 14:59:16 -0500
Subject: Re: Lockup in IDE code
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dan Hollis <goemon@anime.net>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.30.0111091138140.30935-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0111091138140.30935-100000@anime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.49 (Preview Release)
Date: 09 Nov 2001 20:49:22 +0100
Message-Id: <1005335364.15261.19.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 09-11-2001 à 20:38, Dan Hollis a écrit :
> On Fri, 9 Nov 2001, Richard Gooch wrote:
> > GXavier Bestel writes:
> > > le ven 09-11-2001 à 03:17, Richard Gooch a écrit :
> > > >   Hi, all. I tried to use my IDE CD-ROM today, the first time in a
> > > > long while. When attempting to mount it, the machine locked up,
> > > > hard. Even SysReq didn't work.
> > > Do you have a read error on your CD ?
> > No. I did mention that when I turned off DMA, it worked fine.
> 
> I don't see why read errors should lock up the kernel anyway... would it
> be acceptable for floppy read errors to lock up the kernel too?

Indeed, but they do, on my machine anyway.

	Xav

