Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317212AbSFXAXe>; Sun, 23 Jun 2002 20:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSFXAXd>; Sun, 23 Jun 2002 20:23:33 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:64264 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317212AbSFXAXc>; Sun, 23 Jun 2002 20:23:32 -0400
Subject: Re: Gain, 2.5.24 breaks Evolution
From: Miles Lane <miles@megapathdsl.net>
To: Felipe Alfaro Solana <felipe_alfaro@msn.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1024833114.1385.11.camel@teapot>
References: <1024833114.1385.11.camel@teapot>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 23 Jun 2002 17:19:30 -0700
Message-Id: <1024877971.16413.4.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-23 at 04:51, Felipe Alfaro Solana wrote:
> Hello,
> 
> I don't want to be flamed. I know this question has been raised before
> but I haven't been able to find an answer looking at the mail archives.
> 
> Why does 2.5.24 break applications like Evolution 1.0.7 or Ximian Gnome
> Control Center 1.5.13? In both cases, using some functionality that
> spawns new processes causes both applications to hang up. Has anyone
> discovered the cause for this? Do you think it will be fixed soon? I'm a
> little worried about this.

I have conversed with Michael Meeks and Mark McLoughlin about this
problem.  They agree that this is a bug in either the 2.5 kernel
or in ORBit 1.x.  ORBit interacts with the kernel at a pretty
low level in some places.  Neither Michael or Mark have time to
look into this problem at the moment, since they are both busily
working on the Gnome 2.0 release and neither of them have a test
machine with the 2.5 kernel installed.

So, you and I will just have to be patient.  Eventually, this will
get tracked down and fixed.

Best wishes,

	Miles


