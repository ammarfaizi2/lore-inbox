Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWAaQWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWAaQWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWAaQWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:10160 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751135AbWAaQWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:22:46 -0500
Date: Tue, 31 Jan 2006 17:22:43 +0100
From: Kurt Garloff <garloff@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Andreas Schwab <schwab@suse.de>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Rescan SCSI Bus without /proc/scsi?
Message-ID: <20060131162243.GI9188@tpkurt.wlan.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Andreas Schwab <schwab@suse.de>,
	Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051031110344.GA16691@schottelius.org> <je4q6y547h.fsf@sykes.suse.de> <20060131135125.GB9188@tpkurt.wlan.garloff.de> <200601311444.06019.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <200601311444.06019.s0348365@sms.ed.ac.uk>
X-Operating-System: Linux 2.6.16-rc1-git3-5-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 31, 2006 at 02:44:05PM +0000, Alistair John Strachan wrote:
> On Tuesday 31 January 2006 13:51, Kurt Garloff wrote:
> > Attached for reference.
>=20
> From the attachment;
>=20
> if test ! -d /proc/scsi/; then
>   echo "Error: SCSI subsystem not active"
>   exit 1
> fi

SOme work remains to be done :-)

Best,
--=20
Kurt Garloff, Head Architect, Director SUSE Labs (act.), Novell Inc.

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD347TxmLh6hyYd04RAof7AJsH14EMEzLAWfHEFyCJbGyco6M0CACgpYvH
Vw1Xa1JNSbB2h4P8hg9nfxI=
=gXsg
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
