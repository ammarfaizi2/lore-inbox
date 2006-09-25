Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWIYNcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWIYNcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIYNcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:32:31 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:11719
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750993AbWIYNca (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:32:30 -0400
Message-Id: <200609251331.k8PDVOXc006152@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jeff Garzik <jeff@garzik.org>, Grant Coady <gcoady.lk@gmail.com>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 make oldconfig missed SATA
In-Reply-To: Your message of "Mon, 25 Sep 2006 13:25:54 +0400."
             <4517A0A2.5020209@tls.msk.ru>
From: Valdis.Kletnieks@vt.edu
References: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com> <45171EDA.1040602@garzik.org> <200609250038.k8P0cEX1017825@turing-police.cc.vt.edu>
            <4517A0A2.5020209@tls.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159191083_16795P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 09:31:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159191083_16795P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Sep 2006 13:25:54 +0400, Michael Tokarev said:
> Valdis.Kletnieks@vt.edu wrote:
> > So people aren't totally mystified   Admittedly, I've only gotten bit by
> > silently dissapearing symbols 4-5 times since 2.5.55 or so, but the times
> > it happened it would have been nice to know....
> 
> It already does that, but prints them in the beginning, not after config.

Damn, I *never* noticed, because it was scrolled away. ;)

> Try make silentoldconfig and see the first screen of warnings when it will
> ask the first question.

I saw the recent help patches for that - how long has it been in there and I
didn't notice? (Though I admit I say that one and just moved along, thinking
that it was an upstream push of RedHat's linux-2.6-build-nonintconfig.patch
they carry in Fedora, but actually *looking* at that patch, it's something
different).


--==_Exmh_1159191083_16795P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFF9orcC3lWbTT17ARAlJaAJ4wXngx3qlc7jPsCtSkzvM6WYSosQCeLbtz
tZoGNeYL8YHhvrgABp4OYmo=
=o+I4
-----END PGP SIGNATURE-----

--==_Exmh_1159191083_16795P--
