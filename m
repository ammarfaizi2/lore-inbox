Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130709AbQJaV5d>; Tue, 31 Oct 2000 16:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130708AbQJaV5N>; Tue, 31 Oct 2000 16:57:13 -0500
Received: from k2.llnl.gov ([134.9.1.1]:53665 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130502AbQJaV4k>;
	Tue, 31 Oct 2000 16:56:40 -0500
Message-ID: <39FEF93D.2AB63201@scs.ch>
Date: Tue, 31 Oct 2000 08:54:21 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010311943260.1190-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik

Is there any documentation about the Tux zero-copy implementation so
that I don't have to read half of the 2.4 kernel sources before having a
clue? 

Are the kernel changes going to be in the mainstream kernel?

Does Tux implement a new interface so that a userspace app can do
zero-copy stuff with the network?

Sorry for the newbie questions, but it's really hard to find information
about Tux (other than the holy source code, of course ;-)

TIA

Reto

Rik van Riel wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> > Rik van Riel wrote:
> > > On Tue, 31 Oct 2000, Reto Baettig wrote:
> > >
> > > > When I'm following this thread, you guys seem to forget the
> > > > _basics_: The Linux networking stack sucks!
> > >
> > > Ummm, last I looked Linux held the Specweb99 record;
> > > by a wide margin...
> >
> > It doesn't hold the file and print scaling record.  NetWare
> > does..
> 
> Indeed, we haven't made a file serving plugin for
> the TUX zero-copy stuff yet...
> 
> Oh, and I haven't found a bunch of printers yet that are
> fast enough to beat the printserving record ;))
>   *runs like hell*
> 
> cheers,
> 
> Rik
> --
> "What you're running that piece of shit Gnome?!?!"
>        -- Miguel de Icaza, UKUUG 2000
> 
> http://www.conectiva.com/               http://www.surriel.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
