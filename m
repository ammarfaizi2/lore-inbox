Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136429AbRD3Bgp>; Sun, 29 Apr 2001 21:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136428AbRD3Bgg>; Sun, 29 Apr 2001 21:36:36 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:62402 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136433AbRD3BgT>; Sun, 29 Apr 2001 21:36:19 -0400
Message-Id: <5.0.2.1.2.20010430023154.03cd52b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 30 Apr 2001 02:36:17 +0100
To: esr@thyrsus.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Cc: John Stoffel <stoffel@casc.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010429183526.B32748@thyrsus.com>
In-Reply-To: <15084.12152.956561.490805@gargle.gargle.HOWL>
 <20010427193501.A9805@thyrsus.com>
 <15084.12152.956561.490805@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:35 29/04/2001, Eric S. Raymond wrote:
>John Stoffel <stoffel@casc.com>:
> > Also, the buttons on the right hand side for HELP, are wider when they
> > have text in them, but slightly narrower when they are blank.  They
> > should be the same width no matter what.  It looks ragged and ugly.
>
>I know.  Sadly, I couldn't find a way to coerce Tcl into doing this right.

I don't know about whether this is possible with Tcl but have you tried A) 
invisible text and/or B) white space character text (e.g. one or more 
spaces)? That's the kind of thing I usually try in this situation... Just 
an idea...

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

