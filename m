Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269397AbTCDL7O>; Tue, 4 Mar 2003 06:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269398AbTCDL7O>; Tue, 4 Mar 2003 06:59:14 -0500
Received: from daimi.au.dk ([130.225.16.1]:29848 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S269397AbTCDL7N>;
	Tue, 4 Mar 2003 06:59:13 -0500
Message-ID: <3E649774.9DB3868D@daimi.au.dk>
Date: Tue, 04 Mar 2003 13:09:24 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: Miles Bader <miles@gnu.org>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030302125315.GH45@DervishD> <3E620E71.B74C2191@daimi.au.dk> <20030304110213.GA42@DervishD>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
> 
>     Hi Kasper :)
> 
>  Kasper Dupont dixit:
> > > but after a while I made it a symlink to
> > > /var/run/mtab. It worked OK, AFAIK.
> > Did mount actually update the mtab file? The version of mount on
> > my system would not.
> 
>     Of course not, it is just a symlink to a proc file

But you just said it was a symlink to /var/run/mtab.
Did /var/run/mtab get updated?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
