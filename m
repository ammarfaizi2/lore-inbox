Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWBKARq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBKARq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBKARq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:17:46 -0500
Received: from multi.science.ru.nl ([131.174.16.159]:60624 "EHLO
	multi.science.ru.nl") by vger.kernel.org with ESMTP id S932267AbWBKARp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:17:45 -0500
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@kde.org>
To: suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 11 Feb 2006 01:16:51 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz>
In-Reply-To: <20060209232453.GC3389@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25928719.Sq3PCoqClZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602110116.57639.sebas@kde.org>
X-Spam-Score: -1.399 () BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart25928719.Sq3PCoqClZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 11 February 2006 00:35, Pavel Machek wrote:
> So another flamewar is over, good. I even received one apology ;-),
> and probably should have sent some apologies, too...
[...]
> version. How you could help?
>
> * testing is useful at this point. Few confirmations that it works in
> different configurations would make us feel warm and fuzzy.
>
> * documentation improvements, and small scripts. Having script that
> prepares initrd would be nice, for example.
>
> * having someone to maintain suspend.sf.net web pages / release CVS
> snapshot as package would help, too.
>
> * userspace code improvements. Encryption, LZW and graphical progress
> should be reasonably easy to do. There's some tricky stuff, if you
> prefer -- support for swap files and normal files would help,
> too. Plus I guess everyone has their favourite feature...

That all makes sense.

To make uswsusp a success you need it tested [T], supporting scripts [S],=20
someone [B] who puts work in the webpages [W] with decent documentation [D]=
,=20
and a bunch of spiffy features [F].

[T] * http://wiki.suspend2.net/FeatureUserRegister=20
    * http://www.suspend2.net/lists
[S] http://www.suspend2.net/downloads/all/hibernate-script-1.12.tar.gz
[B] Bernard Blackham, b-swweb@blackham.com.au
[W] http://www.suspend2.net
[D] * http://www.suspend2.net/links
    * http://www.suspend2.net/HOWTO
    * http://www.suspend2.net/FAQ
[F] http://www.suspend2.net/features

I, as a contributors to suspend2, have been working on all that stuff for=20
about two-and-a-half years, and it makes me really sad to see that someone =
in=20
a position to make a decision towards progress wants to start that whole=20
process all over, rather than acknowledging the existance of a technical=20
superior solution - including a well-functioning supporting community - and=
=20
working towards getting this solution available for a wider audience.

Judging from experience, uswsusp is probably two years away until it can ev=
en=20
come close to what suspend2 offers right now, and that would be the ideal=20
case of having a lot of people helping in the progress, involving being=20
actively involved and dedicated to fixing problems.
=2D-=20
sebas

 http://www.kde.nl | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
Anything cut to length will be too short.


--nextPart25928719.Sq3PCoqClZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQEVAwUAQ+0s+WdNh9WRGQ75AQJUPQgAs8ntYkwy2opuWLpH9Ug2vXBrIzO1rKZe
5Yya+zpt6iuIsRw3xj4//ucOaL55n95HBl7q3kt7hWLA56w/uqakKu37ae2cpTF1
LxPxFTjoQEPGzDjX067Z7HZ4s3H8iTzbrWpQ1RIzsqworqpqagMn5SCVsVz23/yM
rHZzRw36TJoZzCMQc7dx5lGrxeEHUuyNGN/amd71BjzQCQNmBcPJSH6qJJn5F7PJ
OhX8eXvTLiwoEqLzM7/pD3apbLjm7iof9Y3ceDgNXSdtNrxNnLE3DtwKv6UWvPIg
nl0GOjh9TceX483dQSvu5fSQzgvbmRgHNsVB/fzU4qRC2Z5gPBNDoQ==
=aWha
-----END PGP SIGNATURE-----

--nextPart25928719.Sq3PCoqClZ--
