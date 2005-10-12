Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVJLPsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVJLPsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVJLPsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:48:51 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:37519 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1751465AbVJLPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:48:50 -0400
Date: Wed, 12 Oct 2005 17:48:44 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modalias entries for ccw devices
Message-ID: <20051012154844.GA10587@wavehammer.waldi.eu.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20051012141218.GA4039@wavehammer.waldi.eu.org> <1129127818.32420.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1129127818.32420.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2005 at 04:36:58PM +0200, Martin Schwidefsky wrote:
> Hmm, never heard of modalias. Arnd has done the module loading for ccw
> devices. That must be something rather new.

Yes, it is rather new.

> No, but as far as I can tell after glancing at the modalias
> implementation in usb this would make sense for ccw as well.

Hmm, I don't find device tables in ctc.ko and lcs.ko, can that be fixed
at the same time?

Hmm, something else. Wasn't there a cu type or device type clash between
escon and lcs, or was that only related to chan types reported by the
2.4 kernels?

Bastian

--=20
Emotions are alien to me.  I'm a scientist.
		-- Spock, "This Side of Paradise", stardate 3417.3

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkNNMFwACgkQnw66O/MvCNFBkgCgk97iT9moezyN4Zc8etGj1ZaK
p/cAoJJfUEscMp8bGK5nSlwgo+KTHW6i
=HeGX
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
