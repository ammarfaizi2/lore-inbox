Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316870AbSE1R44>; Tue, 28 May 2002 13:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316871AbSE1R4z>; Tue, 28 May 2002 13:56:55 -0400
Received: from dsl-213-023-038-133.arcor-ip.net ([213.23.38.133]:20361 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316870AbSE1R4y>;
	Tue, 28 May 2002 13:56:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Adam J. Richter" <adam@freya.yggdrasil.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: business models [was patent stuff]
Date: Tue, 28 May 2002 19:52:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: gilad@benyossef.com, linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <200205281713.KAA22774@freya.yggdrasil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Cl8k-0004eq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 May 2002 19:13, Adam J. Richter wrote:
> Alan Cox responds to Gilad Ben-Yossef about licensing of Linux-based patents:
> >I don't think you can realistically expect all open source licenses like
> >the BSD one to be accomodated. Otherwise people would ship binary apps
> >linked with a BSD licensed libpatent.o/c that was useless to anyone. The
> >GPL restrictions happen to work very nicely in terms of making a patent
> >available for free software (or one definition thereof), the BSD license
> >alas doesn't.
> 
> 	You could license all programs that consist entirely of
> free software.  That way, BSD, LGPL, and MPL software that did
> not link in proprietary software would be allowed too,

That's a good start, but it's not enough.  There remains the question of
additional restrictions relating to other programs/hardware/whatever.  The 
Fsmlabs RTLinux patent license is a good example of such additional 
restrictions.  This license restricts the royalty-free grant to software 
that is not realtime, or to software that cannot be freely modified.  The
license does not discriminate on the basis of linking, as the GPL does, but
rather, on the nature of the application.

While it's an open question whether or not this is a suitable way for
Fsmlabs to license their patent, it seems clear that similar restrictions
would be entirely inappropriate for a Linux vendor.

-- 
Daniel
