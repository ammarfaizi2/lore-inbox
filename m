Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUBZWCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUBZWB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:01:26 -0500
Received: from river-bank.demon.co.uk ([62.49.20.162]:297 "EHLO
	badger.river-bank.demon.co.uk") by vger.kernel.org with ESMTP
	id S261168AbUBZV7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:59:50 -0500
From: Phil Thompson <phil@riverbankcomputing.co.uk>
Organization: Riverbank Computing Limited
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ATI IXP IDE support (was: Re: Support for ATI IXP150 Southbridge)
Date: Thu, 26 Feb 2004 21:57:03 +0000
User-Agent: KMail/1.6
Cc: Matthew Tippett <mtippett@ati.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <200402232123.43989.phil@riverbankcomputing.co.uk> <200402241808.22246.phil@riverbankcomputing.co.uk> <200402252108.37225.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402252108.37225.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402262157.03480.phil@riverbankcomputing.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 20:08, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 24 of February 2004 19:08, Phil Thompson wrote:
> > On Monday 23 February 2004 22:54, Bartlomiej Zolnierkiewicz wrote:
> > > On Monday 23 of February 2004 22:23, Phil Thompson wrote:
> > > > Is anybody working on support for the ATI IXP150 Southbridge?
> > > > Particularly the IDE and USB devices.
> > >
> > > IDE support should be added soon (thanks to ATI).
> > >
> > > --bart
> >
> > Great - is there someone I can contact to volunteer to help with testing?
>
> You can find experimental (I have not tested it!) driver for 2.6.3 kernel
> at:
> http://www.kernel.org/pub/linux/kernel/people/bart/atiixp_ide/atiixp_ide-2.
>6.3-1.patch
>
> It was written by Hui Yu <hyu@ati.com>, additional fixes/cleanups by me.
>
> Thanks,
> --bart

Ok, it's installed and seems to be working fine so far. It's a server that's 
still being built so it won't get heavily used yet, but it wouldn't be too 
much of a problem if it got trashed.

Is there any particular testing you'd like me to do - or just shout if I get 
problems?

Phil
