Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVE2ELS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVE2ELS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVE2ELS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:11:18 -0400
Received: from h80ad24ed.async.vt.edu ([128.173.36.237]:52486 "EHLO
	h80ad24ed.async.vt.edu") by vger.kernel.org with ESMTP
	id S261229AbVE2ELN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:11:13 -0400
Message-Id: <200505290408.j4T487n6024489@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Bill Huey <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance 
In-Reply-To: Your message of "Sat, 28 May 2005 20:58:23 MDT."
             <Pine.LNX.4.61.0505282054540.12903@montezuma.fsmlabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com> <1117334933.11397.21.camel@mindpipe>
            <Pine.LNX.4.61.0505282054540.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117339686_6734P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 00:08:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1117339686_6734P
Content-Type: text/plain; charset=us-ascii

On Sat, 28 May 2005 20:58:23 MDT, Zwane Mwaikambo said:
> On Sat, 28 May 2005, Lee Revell wrote:
> 
> > On Sat, 2005-05-28 at 19:55 -0600, Zwane Mwaikambo wrote:
> > > Media apps are actually not that commonplace as far as hard realtime 
> > > applications are concerned.
> > 
> > Audio capture and playback always have a hard realtime constraint.  That
> > is, unless you don't mind your VoIP call sounding as crappy as a cell
> > phone...
> 
> It still doesn't mean that media apps are commonplace and who says cell 
> phones don't use RTOS' for their lower level software stacks?

I'd be wildly surprised if media apps *were* commonplace on an operating
system that didn't supply the needed scheduling infrastructure.

That's as straw-man as commenting that applications that used more than 16
processors weren't commonplace on Linux before the scalability work that made
it feasible to build systems with more than 2 CPUs....

--==_Exmh_1117339686_6734P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCmUAmcC3lWbTT17ARAvZXAKDlKpo8x2Atsb2t4qUoHLpKUZS8rgCglz9S
AmDAVRhdU9auXqAGzdyKBFI=
=9Wa0
-----END PGP SIGNATURE-----

--==_Exmh_1117339686_6734P--
