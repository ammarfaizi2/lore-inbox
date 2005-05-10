Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVEJSte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVEJSte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVEJSte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:49:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9221 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261737AbVEJStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:49:31 -0400
Message-Id: <200505101849.j4AIn4fn019008@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/4] rt_mutex: add new plist implementation 
In-Reply-To: Your message of "Tue, 10 May 2005 11:39:45 PDT."
             <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407> 
From: Valdis.Kletnieks@vt.edu
References: <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115750942_8169P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 May 2005 14:49:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115750942_8169P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 May 2005 11:39:45 PDT, "Perez-Gonzalez, Inaky" said:

> >> At least I'd add return codes for this if the head's priority=20
> >> changes (or in this case, because head's have no prio, if the=20
> >> first node's  prio change).
> >
> >I am not sure I understand you. Why should we track ->prio=20 changes?
> >plist should be generic, I think.
> 
> Errr....shut, that was my or your email program screwing
> things up...that =20, I mean, that's MIME for line break.

Actually, it's the MIME encoding for "blank".  It's usually seen with trailing
blanks, so systems that trim trailing blanks won't molest the one you left on
the end of the line.....


--==_Exmh_1115750942_8169P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCgQIdcC3lWbTT17ARAspwAJ0d41CxjUF+HNLsK29VyBehx8nqyACgjGpq
+H7bpH4IYBHstqjJ36ezfk8=
=7uU3
-----END PGP SIGNATURE-----

--==_Exmh_1115750942_8169P--
