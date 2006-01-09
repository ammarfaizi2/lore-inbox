Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWAINaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWAINaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWAINaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:30:19 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:16269 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751431AbWAINaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:30:17 -0500
Subject: Re: Kernel Education
From: Kasper Sandberg <lkml@metanurb.dk>
To: Weber Ress <ress.weber@gmail.com>
Cc: Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9c2327970601090525v5548034fh780455513b50e8c0@mail.gmail.com>
References: <9c2327970601090500i78fec178mb197c0fa5732e4a4@mail.gmail.com>
	 <43C26357.9050301@liberouter.org>
	 <9c2327970601090525v5548034fh780455513b50e8c0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 09 Jan 2006 14:30:15 +0100
Message-Id: <1136813415.8412.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 11:25 -0200, Weber Ress wrote:
> When I say "more simple" kernel version, I would like say "more
> didactics" to teach.
> 
> thank´s to all replies.
> 
> Best,
> 
> Weber Ress
> 
> On 1/9/06, Jiri Slaby <slaby@liberouter.org> wrote:
> > Weber Ress napsal(a):
> > > Hi guys,
> > >
> > > I´m starting a social project to teach kernel development for young
> > > students, with objetive of include these people in job market.
> > :)
> > >
> > > These studentes don´t have great skills in mathematical and computer
> > > science areas, but have great interest in development area. Some
> > > studentes have a little basic C language skills.
> > >
> > > Which are the first steps that I need in this project ?
> > prepare slides for teaching them real-world-(gc)c, not basic.
> > > Which´s the "more simple" kernel version to teach (2.2 ? 2.4 ? 2.6 ?).
well.. if they were ever to do anything useful with it, it would
basically have to be the newest, alot things have changed in 2.2 to 2.6.
> > IMHO 2.6 has the clearest api (specific(a) rather than sth. like
> > a->private->b->private.specific).
> > But in general it's hard to say this is the simplest one. In 2.2 there is less
> > code, than in 2.6 and so on
> >
> > regards,
> > --
> > Jiri Slaby         www.fi.muni.cz/~xslaby
> > \_.-^-._   jirislaby@gmail.com   _.-^-._/
> > B67499670407CE62ACC8 22A032CC55C339D47A7E
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

