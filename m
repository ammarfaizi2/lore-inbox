Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276622AbRJKRnr>; Thu, 11 Oct 2001 13:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276633AbRJKRni>; Thu, 11 Oct 2001 13:43:38 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:29199 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276622AbRJKRne>; Thu, 11 Oct 2001 13:43:34 -0400
Subject: Re: Which kernel (Linus or ac)?
From: Robert Love <rml@tech9.net>
To: jkp@riker.nailed.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org>
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 11 Oct 2001 13:42:40 -0400
Message-Id: <1002822246.870.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-11 at 10:45, jkp@riker.nailed.org wrote:
> I'm presently running 2.4.8 on a machine. The VM on this is not terribly
> good (swaps a lot with seemlingly plenty of physical memory).
> I'm considering going to an -ac kernel, but I need recent iptables. Is the
> iptables code up to date in -ac?
> Also, which -ac do people recommend? I've beent trying to follow lkm, but
> I'm somewhat confused at this point.

The newest ac is always what is recommended.  Right now that is
2.4.10-ac11.  You will need linux-2.4.10.tar.bz2 and
patch-2.4.10-ac11.bz2.

That code is very stable and has Rik's VM.  It should have the newest
netfilter code -- Alan is very up to date.

This isn't to say not to use Linus's tree, though.  You may want to give
2.4.12 a try, too.

	Robert Love

