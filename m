Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUBRMly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUBRMlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:41:53 -0500
Received: from s199-007.catv.glattnet.ch ([80.242.199.7]:900 "EHLO
	hathi.ethgen.de") by vger.kernel.org with ESMTP id S266573AbUBRMlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:41:52 -0500
Date: Wed, 18 Feb 2004 13:41:41 +0100
From: Klaus Ethgen <Klaus@Ethgen.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [KERNEL] Re: TCP: Treason uncloaked DoS ??
Message-ID: <20040218124141.GA11303@hathi.ethgen.de>
References: <20040218102725.GB3394@hathi.ethgen.de> <20040218105508.GA7320@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040218105508.GA7320@dingdong.cryptoapps.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hi,

Am Mi den 18. Feb 2004 um 11:55 schriebst Du:
> > But 192.168.17.2 is the same host! So the buggy TCP stack seams to
> > be in linux kernel.
> 
> My guess is there is a PacketShaper in between mangling things.

Well, not on this interface. only on my other.

But maybe there is some "interference" between the tc on eth0 and the
eth1...

Gruﬂ
   Klaus
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQDNdhZ+OKpjRpO3lAQG46Qf7BTUtf6mafU6AdpHnzNJ6C04YvC4eYND/
SYUg3OKj0Ffm1jh8li52rdBm22jP05xYxm8DAOUfI9GH3d8ZV2E3MgZ8eqsa5zGx
kqeuPbyk6Emy4eezhdEdmn4VrK4l12ORiefWNmOFzC2vLwSub5palgWGITFxtfLx
FC3If3oChA9SWSkfo1eDoVomM+WTxy7HW2GvNdA4BaFOwW5E/7mgGhB+LuXf1cP+
J8Sc3+Q4+BLyCQFSeNCb5/TgxfC1sVE+JkcxUjGzHvmvz5hySoMUwXq0JN4fKgqH
EboaO2lnPvOuEhzAxSjahCPpy2QEB6pUNpn0/gmkIolfLIvQIzazPQ==
=D/C7
-----END PGP SIGNATURE-----
