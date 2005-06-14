Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVFNDbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFNDbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFNDbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:31:13 -0400
Received: from h80ad2544.async.vt.edu ([128.173.37.68]:36878 "EHLO
	h80ad2544.async.vt.edu") by vger.kernel.org with ESMTP
	id S261349AbVFNDbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:31:11 -0400
Message-Id: <200506140329.j5E3TGYD014420@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance 
In-Reply-To: Your message of "Mon, 13 Jun 2005 17:48:56 PDT."
             <1118710136.2725.36.camel@dhcp153.mvista.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <1117184630.6736.415.camel@tglx.tec.linutronix.de> <20050527091432.GB20512@elte.hu>
            <1118710136.2725.36.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118719754_4874P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 23:29:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118719754_4874P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jun 2005 17:48:56 PDT, Daniel Walker said:
> On Fri, 2005-05-27 at 11:14 +0200, Ingo Molnar wrote:

> > to make sure the wide context has not been lost: no way is IRQ threading 
> > ever going to be the main or even the preferred mode of operation.
> 
> That's depressing .. You not ever submitting IRQ threading upstream ?

My reading was "in the same sense that NUMA and cpusets aren't the main or
preferred mode of operation".  But that's just my reading of it - Ingo may
have meant something else...


--==_Exmh_1118719754_4874P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrk8KcC3lWbTT17ARAm4tAJwLlgK6UTXXcqsbI15ery4Dr6cO4ACgyU1j
bFuHqnQHX7MfAUlUNrfoWyw=
=Sq93
-----END PGP SIGNATURE-----

--==_Exmh_1118719754_4874P--
