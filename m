Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRADVkb>; Thu, 4 Jan 2001 16:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRADVkU>; Thu, 4 Jan 2001 16:40:20 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:7156 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S129763AbRADVkK>; Thu, 4 Jan 2001 16:40:10 -0500
Date: Thu, 4 Jan 2001 21:40:06 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card (VScom): BARs+Offset mix
Message-ID: <20010104214006.C1148@redhat.com>
In-Reply-To: <3A54F743.E04052A4@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A54F743.E04052A4@t-online.de>; from Gunther.Mayer@t-online.de on Thu, Jan 04, 2001 at 11:20:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2001 at 11:20:51PM +0100, Gunther Mayer wrote:

> this mapping must be hardcoded like I did for Timedia serial:

I was thinking about using another flag, like SPCI_FL_SEE_BELOW_TOO,
to mean 'look at the next entry too'.  Then I could just have both
entries there one after the other.

Thoughts?

Tim.
*/

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VO20ONXnILZ4yVIRArpxAKCDbR0jUwp4WCAeQeoSWuPDA1QkRACfWrwg
Y0J5UTRAnMWmnyqERM9jdhs=
=NnRF
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
