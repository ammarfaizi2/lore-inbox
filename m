Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282099AbRLQSm2>; Mon, 17 Dec 2001 13:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282092AbRLQSmW>; Mon, 17 Dec 2001 13:42:22 -0500
Received: from pop.gmx.de ([213.165.64.20]:62167 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281932AbRLQSko>;
	Mon, 17 Dec 2001 13:40:44 -0500
Date: Mon, 17 Dec 2001 19:42:55 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-Id: <20011217194255.1267baa7.sebastian.droege@gmx.de>
In-Reply-To: <Pine.LNX.4.33.0112171822250.28670-100000@Appserv.suse.de>
In-Reply-To: <20011217182343.7aea2048.sebastian.droege@gmx.de>
	<Pine.LNX.4.33.0112171822250.28670-100000@Appserv.suse.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.fAe.)5nqcaTw+."
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.fAe.)5nqcaTw+.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hmm...
I don't see anything about ioapic.c in the patch...
So I removed the apic.c hunk
I think you meant that ;)
Anyway this doesn't solve the problem :(

Bye

On Mon, 17 Dec 2001 18:25:37 +0100 (CET)
Dave Jones <davej@suse.de> wrote:

> On Mon, 17 Dec 2001, Sebastian Dröge wrote:
> 
> > Thanks
> > This does work
> 
> Great, now can you edit the patch to remove the ioapic.c hunk,
> reapply, and see if that works..
> 
> > What do you think was exactly the problem?
> 
> looks like I dorked the apic init...
> I'll back that bit out for -dj2, until I've given
> it a bit more work.
> 
> regards,
> Dave.
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 

--=.fAe.)5nqcaTw+.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8HjyxvIHrJes3kVIRAibXAJ4l93Y3Jjf0nJzqlmdtE9CSOwWGCgCgk7+o
+/IlbOIe67unU50wZ1dAQik=
=dvQ4
-----END PGP SIGNATURE-----

--=.fAe.)5nqcaTw+.--

