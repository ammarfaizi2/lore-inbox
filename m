Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUANKYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUANKYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:24:50 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:52885 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261733AbUANKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:24:49 -0500
Date: Wed, 14 Jan 2004 11:24:25 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: paul.devriendt@amd.com
Cc: pavel@ucw.cz, davej@redhat.com, mark.langsdorf@amd.com,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114102425.GA16995@dominikbrodowski.de>
Mail-Followup-To: paul.devriendt@amd.com, pavel@ucw.cz,
	davej@redhat.com, mark.langsdorf@amd.com, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C080EF398@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF398@txexmtae.amd.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2004 at 08:49:28PM -0600, paul.devriendt@amd.com wrote:
> hardware. Dominik sent me some great patches to use the cpufreq table sup=
port=20
> and remove some redundant code - let me know if you do not have them and
> want me to forward them. They work great.

I've rediffed them for 2.6.1 and put them here:

http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_1

http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_2

http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_3

http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_4

http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_5

Paul: do you agree to them being merged?

	Dominik

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABRjZZ8MDCHJbN8YRAlCVAJwJJtiwUUfmOOuSBQ8r5s1PoJbL+ACfdwBg
dZqq11MubwrApJlGeUzHicY=
=oyRE
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
