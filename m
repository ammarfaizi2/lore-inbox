Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTFKUmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTFKUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:39:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2010 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264449AbTFKUha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:37:30 -0400
Date: Wed, 11 Jun 2003 17:48:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andreas Haumer <andreas@xss.co.at>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
In-Reply-To: <3EE208F1.4000008@xss.co.at>
Message-ID: <Pine.LNX.4.55L.0306111745130.31893@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
 <3EDF3310.7040501@xss.co.at> <3EE208F1.4000008@xss.co.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Jun 2003, Andreas Haumer wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi!
>
> Andreas Haumer wrote:
> > Hi!
> >
> > Marcelo Tosatti wrote:
> >
> >>Hallo,
> >>
> >>Now I really hope its the last one, all this rc's are making me mad.
> >>
> >
> > ;-)
> >
> > So, here's a report on the more positive side...
> >
> I think, I have to take that back... :-((
>
> > As I mentioned in some e-mails in the last few days,
> > I'm currently testing an Asus AP1700-S5 server with
> > a single Xeon 2.4GHz CPU (FSB533), 512MB RAM and
> > 4x36GB U320SCSI drives (3 of them are assembled as RAID5),
> > connected via GBit Ethernet to our internal network
> >
> I had this system running under heavy load for about 24 hours
> without problems. I then stopped the stress testing, and had
> several system freezes since then.
>
> With system freeze I mean:
>
> *) machine doesn't answer to ping, no reaction to console
>    keyboard, no message on the console screen, no message
>    in logfile, no oops, no noticeable system activity

Maybe the NMI oopser helps?
