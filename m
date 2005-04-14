Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVDNTPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDNTPC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDNTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:15:01 -0400
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:49546
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S261585AbVDNTO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:14:57 -0400
In-Reply-To: <8783be66050414102551698d86@mail.gmail.com>
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de> <8783be66050412075218b2b0b0@mail.gmail.com> <20050413183725.GG50241@muc.de> <8783be66050413160033e6283d@mail.gmail.com> <20050413232826.GA22698@redhat.com> <8783be66050414102551698d86@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9--92602720"
Message-Id: <d2274e05b0524222d01c2d584297b4e1@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Egger <de@axiros.com>
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Date: Thu, 14 Apr 2005 21:14:26 +0200
To: Ross Biro <ross.biro@gmail.com>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-9--92602720
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 14.04.2005, at 19:25, Ross Biro wrote:

> Just to be clear, we can have two users A and B with the exact same
> hardware.  A setting of  =y will screw user A and a setting of =n will
> screw user B.  Ideally, they would both get better hardware, but that
> is not always an option.

You tell me a better[1] 32bit GigE PCI adapter than Intel E1000
and I sure do this. It's pretty interesting to see that those
who buy some not-so-cheeep hardware are being screwed in this
case; it should be in Intels best interest to help fix this
issue ASAP and permantently for all users.

[1] better performance at less CPU utilization + good diagnostics
     and negotiation capabilities

Servus,
       Daniel

--Apple-Mail-9--92602720
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCXsETchlzsq9KoIYRAnUxAJ9KSYMkSWqf3upmHBeo+aWD+2r/+ACguxA7
O3KonzJTll1UAYOy9zS+ZZI=
=DqQZ
-----END PGP SIGNATURE-----

--Apple-Mail-9--92602720--

