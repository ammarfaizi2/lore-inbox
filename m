Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRCWKVU>; Fri, 23 Mar 2001 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRCWKVL>; Fri, 23 Mar 2001 05:21:11 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:23831 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129112AbRCWKU7>; Fri, 23 Mar 2001 05:20:59 -0500
Date: Fri, 23 Mar 2001 11:18:26 +0100
From: Kurt Garloff <garloff@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SMP on assym. x86
Message-ID: <20010323111826.E12408@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Pavel Machek <pavel@suse.cz>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010321165541.H3514@garloff.casa-etp.nl> <99anl4oi@penguin.transmeta.com> <20010322132040.A31@(none)>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010322132040.A31@(none)>; from pavel@suse.cz on Thu, Mar 22, 2001 at 01:20:40PM +0000
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2001 at 01:20:40PM +0000, Pavel Machek wrote:
> > Kurt Garloff  <garloff@suse.de> wrote:
> Notice, that one of your CPUs is twice as fast as second one. You'll
> need some heavy updates in scheduler.

I know that making sure to have a fair scheduling on non-symmetric
multiprocessor machiens would require some more work.
I can live with imperfect scheduling ...

Or are you refering to something more serious than non-fairness?
Note: My machine just runs fine for a couple of days now ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6uyLyxmLh6hyYd04RAtoQAJ412NiUT1DrplUNkzLhdROhyBuSPwCgzvjm
6cw2wFcR83NHBbYhviHdWJc=
=el4w
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
