Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTDYQLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTDYQLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:11:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17673 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263366AbTDYQLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:11:13 -0400
Date: Fri, 25 Apr 2003 12:17:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Athanasius <link@miggy.org>
cc: Danny ter Haar <dth@uucp.cistron.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, andre@linux-ide.org,
       andre@linuxdiskcert.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.21-rc1
In-Reply-To: <20030423164015.GJ25981@miggy.org>
Message-ID: <Pine.LNX.3.96.1030424174457.11734G-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY=2feizKym29CxAecD
Content-ID: <Pine.LNX.3.96.1030424174457.11734H@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2feizKym29CxAecD
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.3.96.1030424174457.11734I@gatekeeper.tmr.com>

On Wed, 23 Apr 2003, Athanasius wrote:

>   Yup, that *seems* to have fixed it.  Booted up, updatedb run, compile
> of a few things done, running X, even burned a CD, no sign of the
> reported problem.
> 
>   This could do with some easily accessible documentation someplace, but
> I'm not sure *where* such should go.

I dont think this is a fix, it's a work-around. It shouldn't be
documnented, it should be made to work. That might mean having the kbuild
prevent inappropriate use, of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--2feizKym29CxAecD
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030424174457.11734J@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6mwe8ACgkQIr2uvLNOS8OebgCfWxBnXIUQHOrS67VzwDE5+VNO
8UMAn3vCMFjhls8riL7Vhelihnp+a/+1
=5Ahn
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
