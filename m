Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129524AbQKYR5v>; Sat, 25 Nov 2000 12:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131315AbQKYR5l>; Sat, 25 Nov 2000 12:57:41 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:57585 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S129524AbQKYR5a>; Sat, 25 Nov 2000 12:57:30 -0500
Date: Sat, 25 Nov 2000 15:26:15 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Andries.Brouwer@cwi.nl, greg@linuxpower.cx, viro@math.psu.edu,
        alan@lxorguk.ukuu.org.uk, bernds@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <14878.58.908955.701821@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0011251522430.8818-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Neil Brown wrote:
> On Friday November 24, Andries.Brouwer@cwi.nl wrote:
> > >> ... RedHat's GCC snapshot "2.96" handles this case just fine.
> > 
> > > Now, if you can isolate the relevant part of the diff between
> > > 2.95.2 and RH 2.96...
> > 
> > Maybe I have to be more precise in the statement "gcc 2.95.2 is buggy".

	[image from FTP site not buggy]

> > This is from a SuSE distribution, I forget which, not very recent.
> > Revised summary: gcc-2.95.2-51 from SuSE is buggy.
> 
> Ditto for gcc-2.95.2-13 from Debian (potato). It exhibits the
> same bug. Debian applies a total of 49 patches to gcc and the
> libraries.

The gcc-2.95.2-6cl from Conectiva 6.0 is buggy too.

(and the ISO images haven't even been available for
one week yet ... *sigh*)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
