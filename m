Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRKLXrs>; Mon, 12 Nov 2001 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281213AbRKLXrj>; Mon, 12 Nov 2001 18:47:39 -0500
Received: from mailf.telia.com ([194.22.194.25]:55004 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S281214AbRKLXrW>;
	Mon, 12 Nov 2001 18:47:22 -0500
Message-Id: <200111122347.fACNlIx19565@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Pavel Machek <pavel@suse.cz>, Thomas Foerster <puckwork@madz.net>
Subject: Re: Kernel Module / Patch with implements "sshfs"
Date: Tue, 13 Nov 2001 00:45:29 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011112080214Z281309-17408+13481@vger.kernel.org> <20011112231545.A1081@elf.ucw.cz>
In-Reply-To: <20011112231545.A1081@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 November 2001 23:15, Pavel Machek wrote:
> Hi!
>
> > > A simpler way is to use the kio_fish
> > > And since it is KDE all KDE programs will be able to use it :-)
> > > (To be sure I tried to create a file with advanced editor and save it
> > >  remote - it worked! :-)
> >
> > Seems nice, but the problem is :
> >
> > I'm not using X :)
> >
> > What i want to do is :
> >
> > Mount our external Webserver from our internal Administration Server via
> > 100MBit LAN connection.
>
> Install uservfs(.sf.net), then cd /overlay/#sh:user@host/.
> 								Pavel


Does all X programs support # in filename?

And how do you enter the password?
(Especially if you are using it from an X program.)
I guess you like to avoid entering it on the command line...

But I agree in principe - all kio slaves should really be uservfs slaves...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
