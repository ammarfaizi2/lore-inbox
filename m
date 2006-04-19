Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWDSXSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWDSXSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDSXSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:18:42 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:7855 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S1751284AbWDSXSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:18:41 -0400
Date: Wed, 19 Apr 2006 16:18:31 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Crispin Cowan <crispin@novell.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
Message-ID: <20060419231831.GE13761@suse.de>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	Crispin Cowan <crispin@novell.com>,
	Arjan van de Ven <arjan@infradead.org>, Tony Jones <tonyj@suse.de>,
	linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
	linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <1145470230.3085.84.camel@laptopd505.fenrus.org> <44468817.5060106@novell.com> <Pine.LNX.4.63.0604191904370.11063@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0604191904370.11063@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2006 at 07:05:08PM -0400, Rik van Riel wrote:
> Are confined processes always restricted from starting
> non-confined processes?

It is specified in policy via an unconstrained execution flag: 'ux'. Any
unconfined children can of course do whatever they wish.

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFERsVH+9nuM9mwoJkRAs6gAJ95t8TgZPH380vRVmgDnqsvZt8wFQCeJRwe
pM/6EgMtt9GERHbl1j+rgHM=
=2kO7
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
