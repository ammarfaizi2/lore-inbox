Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268801AbTCDOpT>; Tue, 4 Mar 2003 09:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbTCDOpT>; Tue, 4 Mar 2003 09:45:19 -0500
Received: from [66.70.28.20] ([66.70.28.20]:783 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S268801AbTCDOpT>; Tue, 4 Mar 2003 09:45:19 -0500
Date: Tue, 4 Mar 2003 15:53:59 +0100
From: DervishD <raul@pleyades.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Miles Bader <miles@gnu.org>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030304145359.GB967@DervishD>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030302125315.GH45@DervishD> <3E620E71.B74C2191@daimi.au.dk> <20030304110213.GA42@DervishD> <3E649774.9DB3868D@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E649774.9DB3868D@daimi.au.dk>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Kasper :)

 Kasper Dupont dixit:
> > > > but after a while I made it a symlink to
> > > > /var/run/mtab. It worked OK, AFAIK.
> > > Did mount actually update the mtab file? The version of mount on
> > > my system would not.
> >     Of course not, it is just a symlink to a proc file
> But you just said it was a symlink to /var/run/mtab.

    Excuse me, I thought that you was talking about the /proc/mounts
symlink, and not /var/run/mtab. When the symlink was /var/run/mtab I
don't remeber if it was updated, but it should, because all worked
OK, I mean, all filesystems were correctly mounted. But anyway the
info provided by me is not reliable: we used the 'mount' command from
'asmutils' and I don't know how it managed /etc/mtab. All that
happened more than two years ago :(((, sorry. AFAIK, at some point of
the research, the mount command from busybox was used, too.

    Raúl
