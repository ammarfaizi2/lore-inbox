Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWAINZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWAINZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWAINZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:25:10 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:32905 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751433AbWAINZJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:25:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=be1P0lB+8mTvFGfXtMUioxnpBSf6jHAoSrcg6NVQ2L2NLAxWN6I99UbaRfCnKcPHVRetXWn/HLmW2m5WaG912bLREqs2cdY/gI8uUxLFElB9ZtTcPq6//iNJgN8lW1n/6Lf2V2FmBWBI/r8NkMpI8O0r2pVTO9IS5n6h/zFO5YY=
Message-ID: <9c2327970601090525v5548034fh780455513b50e8c0@mail.gmail.com>
Date: Mon, 9 Jan 2006 11:25:08 -0200
From: Weber Ress <ress.weber@gmail.com>
To: Jiri Slaby <slaby@liberouter.org>
Subject: Re: Kernel Education
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43C26357.9050301@liberouter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <9c2327970601090500i78fec178mb197c0fa5732e4a4@mail.gmail.com>
	 <43C26357.9050301@liberouter.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
