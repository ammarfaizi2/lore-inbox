Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRG1AIi>; Fri, 27 Jul 2001 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRG1AI2>; Fri, 27 Jul 2001 20:08:28 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:61742 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S265844AbRG1AIR>; Fri, 27 Jul 2001 20:08:17 -0400
Date: Sat, 28 Jul 2001 02:06:29 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Kent Hunt <kenthunt@yahoo.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Longstanding sudden reboots with 2.4 smp kernels
Message-ID: <20010728020629.J18981@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Kent Hunt <kenthunt@yahoo.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010727195031.57134.qmail@web14510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
In-Reply-To: <20010727195031.57134.qmail@web14510.mail.yahoo.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2001 at 12:50:31PM -0700, Kent Hunt wrote:
> 	I have a problem that continues to persist since the
> 2.4 test kernels until the latest 2.4.7.
> The machine suddently reboots once in a while when I
> click some action button in the gnomeicu program. I am
> ruling out hardware problems since the box is rock
> solid except in the above mentioned situation. It is
> frustrating since no messages are left in the kernel
> logs when these reboots happen.=20
> 	The box is an ASUS P2BD main board.
> 	Video card Matrox G400.

Power supply?
You may also want to try to reduce AGP to 2x.

Jsut out of curiosity: Do you also see APIC errors in your syslog?

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7YgIExmLh6hyYd04RAjkdAJ4ql85jNjP8HLdGie3xHkHZnHIGAACeIlU3
haRTvt/lqrEgA2c115tAoLM=
=TaFY
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
