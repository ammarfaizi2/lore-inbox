Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbREOVr6>; Tue, 15 May 2001 17:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261603AbREOVrt>; Tue, 15 May 2001 17:47:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54425 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261595AbREOVrf>;
	Tue, 15 May 2001 17:47:35 -0400
Date: Tue, 15 May 2001 17:47:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105151747060.22958-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Richard Gooch wrote:

> Alan Cox writes:
> > > 	len = readlink ("/proc/self/3", buffer, buflen);
> > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > 		exit (1);
> > 
> > And on my box cd is the cabbage dicer whoops
> 
> Actually, no, because it's guaranteed that a trailing "/cd" is a
> CD-ROM. That's the standard.

Set by...?

