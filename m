Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVALIt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVALIt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 03:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVALIt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 03:49:57 -0500
Received: from h80ad2615.async.vt.edu ([128.173.38.21]:53522 "EHLO
	h80ad2615.async.vt.edu") by vger.kernel.org with ESMTP
	id S261297AbVALItx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 03:49:53 -0500
Message-Id: <200501120849.j0C8nkxI000704@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: christos gentsis <christos_gentsis@yahoo.co.uk>
Cc: root <root@mail.gadugi.org>, linux-kernel@vger.kernel.org
Subject: Re: Cherokee Nation Posts Open Source Legisation - Invites comments from Community Members 
In-Reply-To: Your message of "Wed, 12 Jan 2005 07:03:31 GMT."
             <41E4CBC3.4070302@yahoo.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20050106180414.GA11597@mail.gadugi.org> <200501061836.j06IakHo030551@turing-police.cc.vt.edu> <20050106183725.GA12028@mail.gadugi.org> <200501061935.j06JZMq4013855@turing-police.cc.vt.edu>
            <41E4CBC3.4070302@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105519785_20664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jan 2005 03:49:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105519785_20664P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 Jan 2005 07:03:31 GMT, christos gentsis said:

> sorry about this question but i didn't understand something in all this 
> "trade secret" situation...
> 
> first: Is there any impact in GNU GPL?

I'm not a lawyer, just a sysadmin/programmer who follows this sort of stuff,
but it's most likely that this will not impact GPL-licensed software, because
it isn't attempting to restrict what things can be put into GPL software.

If anything, all this law *actually* does is get Cherokee law to match what
current US law *already* says.

> second: does this US law means that everything could be a "trade 
> secret"? even something like the  GUI? or a process bar? and in case 
> that someone will register them what is going to happens?

It's not a US law - it's a proposed Cherokee law (In the US, there exist
some Indian reservations that are somewhat autonomous and able to make their
own laws).

The actual text of the law as proposed is posted at
http://www.gadugi.org/article.php?story=2005010611364165

The Cherokee law would apparently *ban* publishing open source that
contains a trade secret, as that would be a "Willful breach or willful
inducement of a breach of a duty to maintain secrecy;" and therefor a no-no.

(Logic - (1)(d)(i) says it has to be a secret, (1)(d)(ii) says you have to
apply reasonable efforts to *keep* it secret.  Therefore, *publishing* it
would be an "improper" means under (1)(a)(iv), and thus (1)(b)(ii)(B) makes it
"misappropriation"..)

The company can't even claim there is no "breach" or "improper means" because
they intended to publish the source code as open source - because then it no
longer meets the "subject of reasonable efforts to maintain secrecy"
requirement.  If you're not even trying to keep it a secret, it's not a secret.

> third: this under US law, is it applied in EU etc????

It isn't even clear that this law would apply in the US, much less in the EU.

But that's OK, because there's no real danger here, unless you were hoping to
use the Cherokee law to protect secrets in code you publish as open source....


--==_Exmh_1105519785_20664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB5OSpcC3lWbTT17ARAgPiAKCAHKu9aDDOSCohwrZy1+g53NuibgCeNgJR
IWUKv6367IYlGyC2sDsT+Hc=
=x1yj
-----END PGP SIGNATURE-----

--==_Exmh_1105519785_20664P--
