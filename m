Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279588AbRJXUWk>; Wed, 24 Oct 2001 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRJXUWa>; Wed, 24 Oct 2001 16:22:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52234 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279588AbRJXUWM>; Wed, 24 Oct 2001 16:22:12 -0400
Date: Wed, 24 Oct 2001 17:01:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jonas Berlin <jonas@berlin.vg>
Cc: Shawn Walker <swalker@fs1.theiqgroup.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wanderlei Antonio Cavassin <cavassin@conectiva.com.br>,
        "Juan J. Quintela" <quintela@fi.udc.es>
Subject: Re: status of supermount?
In-Reply-To: <20011024200049.A20340@niksula.hut.fi>
Message-ID: <Pine.LNX.4.21.0110241700070.1138-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Oct 2001, Jonas Berlin wrote:

> > Does anyone know if supermount has been ported to a more recent
> > kernel by anyone? The last version of supermount I could find
> > was for 2.4.0
> 
> I mailed the same question to the maintainer over six months ago but didn't
> get any answer. So I upgraded the patch myself to work with versions 2.4.2,
> 2.4.4 and 2.4.5. At some point I switched to using 2.4.4-ac9, which I am
> still using without problems, but I didn't have time back then to port the
> patch to that version.
> 
> I have no idea if anyone else has done anything similar. Personally I
> initially found this patch as a part of the standard kernel provided by
> mandrake 7.2 (most likely), but I don't know whether they have it in there
> anymore. I'll check that out. Anyway, if nobody else is already doing it, I
> could try my best to port it to the newer kernels available, and also to the
> -ac series, and if I succeed, possibly continue porting it when new versions
> arrive. I'd be happy to have supermount support back in there myself too.
> 
> As this is the first part of kernel software I have been porting anyway,
> I'll happily listen to good advice and pointers to resources that could help
> me figuring out what interface changes etc there has been in the 2.4 series.
> I remember there being multiple changes already between 2.4.0 and 2.4.4 that
> required changing some code, partially because the patch also includes some
> small changes to some generic fs code (mostly locking issues).

Last I heard, Juan J. Quintela <quintela@fi.udc.es> was porting supermount
to 2.4.x.

>From what I heard from him its not an easy job: the current 2.4.x
available patches are full of problems.

