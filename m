Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUCWLs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUCWLs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:48:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262517AbUCWLsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:48:12 -0500
Date: Tue, 23 Mar 2004 12:47:26 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Cameron Patrick <cameron@patrick.wattle.id.au>,
       Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] lzf license
Message-ID: <20040323114725.GD13666@devserv.devel.redhat.com>
References: <opr49atvpk4evsfm@smtp.pacific.net.th> <20040322094053.GO16890@patrick.wattle.id.au> <1079948988.5296.8.camel@laptop.fenrus.com> <20040322182121.GA21521@schmorp.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20040322182121.GA21521@schmorp.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 22, 2004 at 07:21:21PM +0100, Marc Lehmann wrote:
> If there are unavoidable reasons why the GPL is required, then I'd bite
> the bullet and dual-license it, in the hope that further bugfixes or
> modifications will be contributed under both licenses.

dual licensing is a LOT easier. Really; esp since it becomes GPL anyway sort
of when it's distributed as part of the kernel..
About bugfixes; I'd recommend using something like:

    Alternatively, the contents of this file may be used under the
    terms of the GNU General Public License version 2 (the "GPL"), in which
    case the provisions of the GPL are applicable instead of the
    above.  If you wish to allow the use of your version of this file
    only under the terms of the GPL and not to allow others to use
    your version of this file under the BSD license, indicate your decision
    by deleting the provisions above and replace them with the notice
    and other provisions required by the GPL.  If you do not delete
    the provisions above, a recipient may use your version of this
    file under either the BSD or the GPL.

like the pcmcia code does; eg you say "if you send me stuff I assume it's
dual licensed too unless you indicate otherwise".

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAYCPMxULwo51rQBIRAgRxAJ410hF4IQp//nYwwM4k94nabswofwCeJDwr
r91KUD89jLMnKqYr1RCCoXo=
=OVuG
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
