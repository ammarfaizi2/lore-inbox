Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUASLGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUASLGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:06:06 -0500
Received: from dsl-213-023-008-082.arcor-ip.net ([213.23.8.82]:3543 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S264527AbUASLF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:05:58 -0500
To: fcp <fcp@pop.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ISDN CAPI (avm b1pci) doesn't work, occasionally
 freezes Kernel (2.6.1)
References: <200401181746.i0IHkO2G002776@reason.gnu-hamburg>
	<1074468927.2722.2.camel@server>
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Mon, 19 Jan 2004 12:05:45 +0100
In-Reply-To: <1074468927.2722.2.camel@server> (fcp@pop.co.za's message of
 "Sun, 18 Jan 2004 21:35:27 -0200")
Message-ID: <m3r7xwqjue.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Sun, 18 Jan 2004 21:35:27 -0200
 || fcp <fcp@pop.co.za> wrote: 

 f> I had similar problems. Running RH9, 2.6.1, W6692 pci card. Spent
 f> quite some time chasing this and in the end installed mISDN beta
 f> and it worked the first time. No nonsense. Hope this helps

Thanks.

I wonder. If it is a known problem that ISDN doesn't work for multiple
cards in 2.6.1: Are there plans to incorporate mISDN officially?

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--
--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFAC7oJbvivwoZXSsoRAndLAJ0XBnGFyZXeb5eg+7ZwdM1XFy2o4QCeKc3t
PUM8wQTsWBnhe3zCHAJFJ2w=
=o8nQ
-----END PGP MESSAGE-----
--==-=-=--
