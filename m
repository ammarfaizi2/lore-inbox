Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVEQUfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVEQUfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVEQUfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:35:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13074 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261939AbVEQUfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:35:22 -0400
Message-Id: <200505172035.j4HKZGgB029870@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: Karel Kulhavy <clock@twibright.com>, Takashi Iwai <tiwai@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ALSA make menuconfig Help description missing 
In-Reply-To: Your message of "Tue, 17 May 2005 15:30:16 EDT."
             <1116358216.32062.7.camel@mindpipe> 
From: Valdis.Kletnieks@vt.edu
References: <20050517123549.GA2378@kestrel> <s5hfywmotdd.wl@alsa2.suse.de> <20050517145931.GA11564@kestrel>
            <1116358216.32062.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116362115_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 16:35:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116362115_5349P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 15:30:16 EDT, Lee Revell said:

> There is no official user level documentation for dmix (which runs in
> userspace anyway), because it was not intended to be configured by the
> end user.  The current ALSA version, 1.0.9-rcX, uses dmix by default.
> 
> It's always a pain to get OSS apps to play nice with dmix, which is why
> the real solution is to get proper ALSA support in Skype.

Blech. Explains why I can't find the kernel piece for it. ;)

--==_Exmh_1116362115_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCilWDcC3lWbTT17ARAtXTAJ9NmuN8YOJ2GjckBeyIYTc4oq3y8ACeJ13P
psREdbcNR5S62KMXXOoTISs=
=Ky4f
-----END PGP SIGNATURE-----

--==_Exmh_1116362115_5349P--
