Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbREOWZS>; Tue, 15 May 2001 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261647AbREOWY6>; Tue, 15 May 2001 18:24:58 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48284 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261646AbREOWYx>; Tue, 15 May 2001 18:24:53 -0400
Date: Tue, 15 May 2001 16:24:45 -0600
Message-Id: <200105152224.f4FMOjj02219@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151747060.22958-100000@weyl.math.psu.edu>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0105151747060.22958-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Tue, 15 May 2001, Richard Gooch wrote:
> 
> > Alan Cox writes:
> > > > 	len = readlink ("/proc/self/3", buffer, buflen);
> > > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > > 		exit (1);
> > > 
> > > And on my box cd is the cabbage dicer whoops
> > 
> > Actually, no, because it's guaranteed that a trailing "/cd" is a
> > CD-ROM. That's the standard.
> 
> Set by...?

Me&Linus. The device name authority (Peter). Whoever. If you want
Peter to bless it, then fine. But the standard is there. Violators
will be persecuted.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
