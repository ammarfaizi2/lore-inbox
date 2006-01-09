Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWAINcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWAINcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWAINcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:32:01 -0500
Received: from host217-46-213-187.in-addr.btopenworld.com ([217.46.213.187]:55143
	"EHLO help.basilica.co.uk") by vger.kernel.org with ESMTP
	id S1751456AbWAINcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:32:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel Education
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 9 Jan 2006 13:35:20 -0000
Message-ID: <8941BE5F6A42CC429DA3BC4189F9D442014FB5@bashdad01.hd.basilica.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel Education
Thread-Index: AcYVILUxYMNWrWkgTYGjDNTIA+P4BQAALGlQ
From: "Khushil Dep" <khushil.dep@help.basilica.co.uk>
To: "Weber Ress" <ress.weber@gmail.com>, "Jiri Slaby" <slaby@liberouter.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before you start in on the Linux kernel I'd suggest you get you students well grounded in operating systems theory. It's a rather huge field of study but just teaching people bits of the kernel is going to be a waste of time if they don't have the comprehension of the whole.

-----------------------
Khushil Dep

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Weber Ress
Sent: 09 January 2006 13:25
To: Jiri Slaby
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Education

When I say "more simple" kernel version, I would like say "more
didactics" to teach.

thank´s to all replies.

Best,

Weber Ress

On 1/9/06, Jiri Slaby <slaby@liberouter.org> wrote:
> Weber Ress napsal(a):
> > Hi guys,
> >
> > I´m starting a social project to teach kernel development for young
> > students, with objetive of include these people in job market.
> :)
> >
> > These studentes don´t have great skills in mathematical and computer
> > science areas, but have great interest in development area. Some
> > studentes have a little basic C language skills.
> >
> > Which are the first steps that I need in this project ?
> prepare slides for teaching them real-world-(gc)c, not basic.
> > Which´s the "more simple" kernel version to teach (2.2 ? 2.4 ? 2.6 ?).
> IMHO 2.6 has the clearest api (specific(a) rather than sth. like
> a->private->b->private.specific).
> But in general it's hard to say this is the simplest one. In 2.2 there is less
> code, than in 2.6 and so on
>
> regards,
> --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> \_.-^-._   jirislaby@gmail.com   _.-^-._/
> B67499670407CE62ACC8 22A032CC55C339D47A7E
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
