Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbUDGS6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUDGS6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:58:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22403 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264116AbUDGS6g (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:58:36 -0400
Message-Id: <200404071858.i37IwDpr012972@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Sean Neakums <sneakums@zork.net>, Mohamed Aslan <mkernel@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Rewrite Kernel 
In-Reply-To: Your message of "Wed, 07 Apr 2004 09:58:49 EDT."
             <Pine.LNX.4.53.0404070957490.10718@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <6un05oszfx.fsf@zork.zork.net>
            <Pine.LNX.4.53.0404070957490.10718@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-276879822P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Apr 2004 14:58:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-276879822P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Apr 2004 09:58:49 EDT, "Richard B. Johnson" said:

> It's called a compiler and we already have several versions, none
> optimum.

However, I do believe that all the currently supported compilers are able
to beat out any programmers over the long run - we can use asm tricks
to hand-tune very small sections of hot-spot code, but nobody can sustain
that level of hand-optimization for 10K or 20K lines of code.

Anybody thinking of this is almost surely better off spending their time
coming up with new and better algorithms.

--==_Exmh_-276879822P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAdE9FcC3lWbTT17ARAuUsAJ9GKYhgA0mPXn5Oe5J4sG+VSSkokwCeNXwm
RfGmwhEkEdxHq5IfZLpiwbg=
=E1/7
-----END PGP SIGNATURE-----

--==_Exmh_-276879822P--
