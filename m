Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315780AbSETFMa>; Mon, 20 May 2002 01:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315786AbSETFM3>; Mon, 20 May 2002 01:12:29 -0400
Received: from panda.sul.com.br ([200.219.150.4]:36102 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S315780AbSETFM1>;
	Mon, 20 May 2002 01:12:27 -0400
Date: Sun, 19 May 2002 17:12:07 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020519201207.GA6690@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com> <E179fAd-0005vs-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 20, 2002 at 02:53:18PM +1000, Rusty Russell escreveu:
> > So a lot of people didn't get it? Arnaldo seems to have fixed a lot of
> > them already
> 
> Yeah, thanks to my kernel audit.  But I won't be auditing all 5,500
> every release (I promised Alan I'd do 2.4 though: I'm waiting for the
> next Marcelo kernel).

Yeah, that put the needed pressure for the patches to get accepted ;) I and
others had done most of that in the past but patches were getting lost in the
noise, now they are getting in much more easily 8)

http://kerneljanitors.org/TODO had that listed for a long time 8)

Anyway, thanks again for the audit! :-)

And I'm all for something that is more easy to use, as I, like you, don't
want to keep auditing for the very same thing over and over again.

- Arnaldo
