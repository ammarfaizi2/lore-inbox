Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSDEDNb>; Thu, 4 Apr 2002 22:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSDEDNV>; Thu, 4 Apr 2002 22:13:21 -0500
Received: from pc2-midd4-0-cust131.mid.cable.ntl.com ([213.107.124.131]:29583
	"EHLO harry.vipersoft.co.uk") by vger.kernel.org with ESMTP
	id <S312194AbSDEDNK>; Thu, 4 Apr 2002 22:13:10 -0500
Date: Fri, 5 Apr 2002 04:13:09 +0100
From: dean@vipersoft.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: Re: faster boots?
Message-ID: <20020405031309.GC32647@vipersoft.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.0994.1017972604.0.67144600@webmail.atl.earthlink.net> <E16tJhD-0007MA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > If the video card is old and slow, could all this extra stuff that
> > scrolls up the screen be causing the issue?  If so is there a way of
> > turning this off?
>
> Boot with the "quiet" option to quieten messages. (I think its quiet
> anyway)

Yes, just add the line:
append="quiet" to the correct section in your lilo.conf to have the
initial bootup messages turned off.  You can still access these messages
via dmesg of course.

HTH and HAND.

- Dean

ps Alan (sorry for the cc to you - I slipped;)

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjytFkQACgkQvSGdOzz96ZUeqQCdH8s7LzvFS0jXhZKWH0NBELWX
E0oAoKVhHV7bTUiDte2wbwyLpugoPKkp
=w/9w
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
