Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316069AbSE3Bce>; Wed, 29 May 2002 21:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSE3Bcd>; Wed, 29 May 2002 21:32:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12816 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316069AbSE3Bcb>; Wed, 29 May 2002 21:32:31 -0400
Date: Wed, 29 May 2002 21:34:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Greg KH <greg@kroah.com>
Subject: Re: Linux 2.4.19-pre9
In-Reply-To: <20020529053732.GH6521@marowsky-bree.de>
Message-ID: <Pine.LNX.4.44.0205292123520.9955-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 May 2002, Lars Marowsky-Bree wrote:

> On 2002-05-28T19:06:42,
>    Marcelo Tosatti <marcelo@conectiva.com.br> said:
>
> Good morning Marcelo, could you please also consider switching to the somewhat
> more dense format used by Linus recently? It makes the changelogs a lot more
> readable.

I guess I'll use Matthias changelog.pl. Havent tested it yet, though.

> As a further comment:
>
> > <greg@kroah.com> (02/05/03 1.408)
> > 	USB io_edgeport driver
> >
> > <davem@nuts.ninka.net> (02/05/06 1.383.11.22)
> > 	soft-fp fix:
> >
> > <colin@gibbs.dhs.org> (02/05/07 1.383.11.23)
> > 	copy_mm fix:
>
> and alike aren't actually very useful one-line summaries of the patch in
> question to a "casual" reader, sorry.

I got them through BK pull: I can't change comments of those patches.

David, Greg, and others, please, more readable changelogs :)

> In the first case, I can guess that probably, it is a new driver added; or
> maybe it is just an update to an existing one? In the later two, what is
> fixed? How does it affect my own code, or my running system?
>
> The good work by all contributors not withstanding, it would be very nice if
> they could make the summary slightly more useful before sending a patch to
> Marcelo, for which I would like to thank everyone in advance ;-)

I have to change a patch's changelog (which is the message body which
people send me in case of a GNU patch) pretty often to make it more
readable.

I just can't change all of them.



