Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280898AbRKYPvI>; Sun, 25 Nov 2001 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKYPu6>; Sun, 25 Nov 2001 10:50:58 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:4749 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280898AbRKYPus>; Sun, 25 Nov 2001 10:50:48 -0500
Subject: Re: Severe Linux 2.4 kernel memory leakage
From: Chris Chabot <chabotc@reviewboard.com>
To: Phil Sorber <aafes@psu.edu>
Cc: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1006702918.3088.3.camel@praetorian>
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com> 
	<tgy9kuevtw.fsf@mercury.rus.uni-stuttgart.de> 
	<1006702226.1316.2.camel@gandalf.chabotc.com> 
	<1006702918.3088.3.camel@praetorian>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 25 Nov 2001 16:51:04 +0100
Message-Id: <1006703464.1316.6.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil, I think you are right. When i look @ /boot (good way of seeing,
which & when) it tells me that my upgrade schedule was:

Aug 22  2001 bzImage-2.4.9
Sep 27 07:17 bzImage-2.4.10
Oct 12 04:27 bzImage-2.4.11
Oct 12 16:58 bzImage-2.4.12
Nov 8 17:26 bzImage-2.4.13
Nov 10 10:41 bzImage-2.4.14
Nov 24 10:46 bzImage-2.4.15

So apearantly 2.4.11 was dont use (2.4.12 followed later the same day in
my upgrade cycle). Then for almost a month no upgrades while running
2.4.12, and from there on folowing the kernel upgrade cycle again.

	-- Chris


On Sun, 2001-11-25 at 16:41, Phil Sorber wrote:
> On Sun, 2001-11-25 at 10:30, Chris Chabot wrote:
> > The kernel i ran for about a month was kernel 2.4.11.
> > 
> 
> wasn't kernel 2.4.11 labeled "dontuse"?
> 
> that had a serious bug in it.
> 
> > 
> -- 
> Phil Sorber
> AIM: PSUdaemon
> IRC: irc.openprojects.net #psulug PSUdaemon
> GnuPG: keyserver - pgp.mit.edu


