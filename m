Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUAVXxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266340AbUAVXxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:53:24 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:33802 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S265094AbUAVXxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:53:22 -0500
Date: Thu, 22 Jan 2004 18:53:20 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Mark Borgerding <mark@borgerding.net>, linux-kernel@vger.kernel.org
Subject: Re: ALSA vs. OSS
Message-ID: <20040122235320.GA21836@babylon.d2dc.net>
Mail-Followup-To: Jaroslav Kysela <perex@suse.cz>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Mark Borgerding <mark@borgerding.net>, linux-kernel@vger.kernel.org
References: <1074532714.16759.4.camel@midux> <200401201046.24172.hus@design-d.de> <400D2AB2.7030400@borgerding.net> <200401201513.45564.s0348365@sms.ed.ac.uk> <Pine.LNX.4.58.0401201615480.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401201615480.2010@pnote.perex-int.cz>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2004 at 04:19:29PM +0100, Jaroslav Kysela wrote:
> On Tue, 20 Jan 2004, Alistair John Strachan wrote:
> > If ALSA does or could support working with the programmable dsp, I'd be=
 happy=20
> > to switch to it. Right now my "deprecated" SBLive! OSS drivers output h=
igher=20
> > quality audio.
>=20
> We don't have user space tools to update DSP code although our emu10k1
> driver is capable to do it. Sure, we are doing things differently than OSS
> driver so you cannot simply use the OSS utilities.
>=20
> Perhaps, time to help us?

Is there any documentation on the interface for uploading new DSP code
to the emu10k1?

Such would be /very/ useful for the task of writing tools to do the job.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

   "Never attribute to malice that which can be adequately explained by
stupidity" - Hanlon's Razor

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEGJwRFMAi+ZaeAERAvXcAJ4lH75rl1eZ6oj1RXuUyVOpwbFD+gCg1npe
AyR6vGqxFQVMV0LcYwY6B08=
=TJ+p
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
