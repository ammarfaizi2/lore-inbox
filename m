Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbSIZSKv>; Thu, 26 Sep 2002 14:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSIZSKv>; Thu, 26 Sep 2002 14:10:51 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:11593 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261420AbSIZSKu>;
	Thu, 26 Sep 2002 14:10:50 -0400
From: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Page table sharing
Date: Thu, 26 Sep 2002 20:20:08 +0200
User-Agent: KMail/1.4.7
References: <200209252013.17714.gjwucherpfennig@gmx.net> <59570000.1032979211@baldur.austin.ibm.com>
In-Reply-To: <59570000.1032979211@baldur.austin.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209262020.30679.gjwucherpfennig@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday September 25 2002 20:40, Dave McCracken <dmccr@us.ibm.com> wrote:
> --On Wednesday, September 25, 2002 20:12:36 +0200 "Gerold J. Wucherpfennig"
> <gjwucherpfennig@gmx.net> wrote:
...
> > Some comments from Daniel Phillips or Dave McCracken?
>
> I'm working on it.  I sent out a patch to the mm list a few weeks ago, but
> it didn't have the locking right.  I'm in the proces of finishing an
> improved version with new locking.  I'll send a snapshot of it out when I
> can make it stop oopsing :)
>
...

Oh, really geat :-)

I hope you will get it stable till Halloween...
...hopefully somebody will help you.
Page table sharing seems to be very useful,
but I'm no expert. I only read about it at LWN
and Kernel Traffic.


Gerold

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9k0/Y53zyw+ONqrERAkauAJ0b3ztvgORi6c7rgSbhD3IIQh5v3ACdG2ou
Ds2vW/vuXHlk1NU/Hau3NNk=
=FgOz
-----END PGP SIGNATURE-----

