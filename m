Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUJOUPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUJOUPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUJOUPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:15:18 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:60831 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267601AbUJOUOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:14:51 -0400
Date: Fri, 15 Oct 2004 22:11:47 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Josh Boyer <jdub@us.ibm.com>
Cc: root@chaos.analogic.com, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041015201147.GA23355@thundrix.ch>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com> <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net> <1097857049.29988.29.camel@weaponx.rchland.ibm.com> <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com> <1097862366.29988.51.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1097862366.29988.51.camel@weaponx.rchland.ibm.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Oct 15, 2004 at 12:46:06PM -0500, Josh Boyer wrote:
> I'd disagree.  Do you consider SELinux to be policy as well just because
> it's in the kernel?
>=20
> As David said in his response, it's a mechanism.  Whether _you_ choose
> to use it or not decides the "policy".  That's why I said put a config
> option around it.  You would still have _choice_.

Actually,  even though I  agree that  Richard is  overdramatizing, his
point is  not completely  invalid.  Remembering the  trusted computing
initiative,  it's always  a question  of who  holds the  keys  to your
computer.   In our  case it's  no problem,  since we  compile  all the
software on the computer ourselves, and thus we have full control over
what we do.

What trusted computing revealed is that there is at least amongst some
companies  a desire  to be  able to  dictate what's  going on  on your
computer. Think Disney here.

Sure, TCPA is dead.  But I've seen a TPM chip. On an Intel test board.
IBM has  them as well.  I agree  that we can trust  all these entities
now. But what's going to happen ten years from now? We don't know.

I'm not  proclaiming paranoia. I don't  say we should  burn this patch
alive. I only say  that from time to time we have  to take care of not
getting to the Wernher von Braun excuse.

			    Tonnerre

PS. I did a module signing patch  some years ago. I did a framework. I
    did tests. I got scared of its power. All I say is, take care.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBcC8D/4bL7ovhw40RAhewAJ47vYTolk9xUd7/dI+TtUnO5yxlJQCfbGTa
7dCsPHIE4R9eME5c0ho+N1M=
=h8ff
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
