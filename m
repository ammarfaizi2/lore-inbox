Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUANKL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUANKL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:11:27 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:57336 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S266149AbUANKLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:11:25 -0500
Date: Wed, 14 Jan 2004 11:10:41 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com, pavel@ucw.cz,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114101041.GB16737@dominikbrodowski.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	paul.devriendt@amd.com, pavel@ucw.cz, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com> <20040113230605.GM14674@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20040113230605.GM14674@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2004 at 11:06:05PM +0000, Dave Jones wrote:
> Part of the justification for cpufreq (at least on x86) was an alternative
> for when ACPI just doesn't work, or for when folks either don't want to,
> or can't run ACPI (through various other AML bugs for eg).

Except that the ACPI P-States implementation also uses the cpufreq
infrastructure.

	Dominik
--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABRWhZ8MDCHJbN8YRAmDFAJ9gOP+vbzJS0uHO7FG/NTSsRLYpGQCeMGIP
SYuEdVcscqj6H0wnUhnVLw8=
=NH+k
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
