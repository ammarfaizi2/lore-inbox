Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131491AbQKYSwk>; Sat, 25 Nov 2000 13:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131430AbQKYSwa>; Sat, 25 Nov 2000 13:52:30 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60686 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129648AbQKYSwL>; Sat, 25 Nov 2000 13:52:11 -0500
Date: Sat, 25 Nov 2000 12:16:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andries.Brouwer@cwi.nl,
        greg@linuxpower.cx, viro@math.psu.edu, alan@lxorguk.ukuu.org.uk,
        bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <20001125121654.E29510@vger.timpanogas.org>
In-Reply-To: <14878.58.908955.701821@notabene.cse.unsw.edu.au> <Pine.LNX.4.21.0011251522430.8818-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011251522430.8818-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Nov 25, 2000 at 03:26:15PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 03:26:15PM -0200, Rik van Riel wrote:

Rik,

We refuse to use it here at present.  Builds from it have a lot
of problems, for some reason.  Andre is looking into it more 
deeply than I, but I agree with your assessment.

Jeff


> On Fri, 24 Nov 2000, Neil Brown wrote:
> > On Friday November 24, Andries.Brouwer@cwi.nl wrote:
> > > >> ... RedHat's GCC snapshot "2.96" handles this case just fine.
> > > 
> > > > Now, if you can isolate the relevant part of the diff between
> > > > 2.95.2 and RH 2.96...
> > > 
> > > Maybe I have to be more precise in the statement "gcc 2.95.2 is buggy".
> 
> 	[image from FTP site not buggy]
> 
> > > This is from a SuSE distribution, I forget which, not very recent.
> > > Revised summary: gcc-2.95.2-51 from SuSE is buggy.
> > 
> > Ditto for gcc-2.95.2-13 from Debian (potato). It exhibits the
> > same bug. Debian applies a total of 49 patches to gcc and the
> > libraries.
> 
> The gcc-2.95.2-6cl from Conectiva 6.0 is buggy too.
> 
> (and the ISO images haven't even been available for
> one week yet ... *sigh*)
> 
> regards,
> 
> Rik
> --
> Hollywood goes for world dumbination,
> 	Trailer at 11.
> 
> http://www.conectiva.com/		http://www.surriel.com/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
