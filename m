Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVBKUIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVBKUIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVBKUIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:08:13 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:22950 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262331AbVBKUHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:07:00 -0500
Message-ID: <420D1050.3080405@t-online.de>
Date: Fri, 11 Feb 2005 21:06:40 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
References: <20050211004033.GA26624@suse.de>
In-Reply-To: <20050211004033.GA26624@suse.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCFEF27ECF6D49C77F10AB6F4"
X-ID: rfc8nrZEweIYdJbXfn3aHM-LiiwuFDVLg8aAwCOYfQauRpG7KIojgO
X-TOI-MSGID: a252d58d-c817-4d3b-be6d-7b1c609a3e4f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFEF27ECF6D49C77F10AB6F4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> I'd like to announce, yet-another-hotplug based userspace project:
> linux-ng.  This collection of code replaces the existing linux-hotplug
> package with very tiny, compiled executable programs, instead of the
> existing bash scripts.
>

cpio is running to setup a test partition.

But one question: This is yet another package with its
own private copy of klibc. Whats the reason behind this
non-modular approach?


Regards

Harri

--------------enigCFEF27ECF6D49C77F10AB6F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCDRBWUTlbRTxpHjcRAm9ZAJ9N7T+HA6gpTwTimWjEU3RFUu7PaACeLc4c
BKp6uknosnjEuTFz1r0sElQ=
=yOrN
-----END PGP SIGNATURE-----

--------------enigCFEF27ECF6D49C77F10AB6F4--
