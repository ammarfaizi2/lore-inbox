Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269203AbRGaHv6>; Tue, 31 Jul 2001 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269205AbRGaHvj>; Tue, 31 Jul 2001 03:51:39 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:26116 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S269203AbRGaHvf>; Tue, 31 Jul 2001 03:51:35 -0400
Date: Tue, 31 Jul 2001 09:51:41 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: serial console and kernel 2.4
Message-ID: <20010731095141.A28761@pc8.lineo.fr>
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain> <20010731045527.A5863@weta.f00f.org> <996525392.3352.4.camel@tduffy-lnx.afara.com> <20010731094118.B6318@weta.f00f.org> <9k4mqg$1ch$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <9k4mqg$1ch$1@ncc1701.cistron.net>; from miquels@cistron-office.nl on mar, jui 31, 2001 at 00:24:16 +0200
X-Mailer: Balsa 1.1.7-cvs20010726
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Debian/Sid, sysinit is uptodate as usual. 
Unfortunately I've also to deal with RHbox. 
In RedHat Rawhide the current version is SysVinit-2.78-18 and is patched
for the CREAD bug.
So If you have a RedHat box, update your SysInit package up to 2.78-18.

Thank you Miguel for your work (and for your fortune, I like it).

Christophe


Le mar, 31 jui 2001 00:24:16, Miquel van Smoorenburg a écrit :
> In article <20010731094118.B6318@weta.f00f.org>,
> Chris Wedgwood  <cw@f00f.org> wrote:
> >On Mon, Jul 30, 2001 at 01:36:32PM -0700, Thomas Duffy wrote:
> >
> >    to what?  and which version is broken?
> >
> >No idea, whatever debian ships with.
> >
> >The reason I use debian is 'things just work' --- presumably redhat
> >has an update for sysvinit, so just snarf the latest and see if that
> >helps.
> 
> sysvinit 2.80 is now in debian unstable, it fixes the CREAD bug.
> It might take 1 or 2 days for the alpha/mips/etc autobuilders to
> catch up and produce a .deb for those platforms.
> 
> Mike.
> -- 
> "dselect has a user interface which scares small children"
> 	-- Theodore Tso, on debian-devel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
