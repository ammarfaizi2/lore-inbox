Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUCPOUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUCPOS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:18:27 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:44217 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261844AbUCPOF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:05:59 -0500
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Remove pmdisk from kernel
Date: Mon, 15 Mar 2004 17:32:39 -0800
User-Agent: KMail/1.6.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040315195440.GA1312@elf.ucw.cz> <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz>
In-Reply-To: <20040315205752.GG258@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403151732.42700.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

15 March 2004 12:57, Pavel Machek wrote:

> > > PS: Alternatively, I'm wiling to kill swsusp, rename pmdisk to
> > > "swap suspend", and submit patches to fix it. Its going to be
> > > slightly more complicated, through...
> >
> > People have suggested that I incorporate swsusp2.  Where does
> > this fit into things?
>
> I believe that you don't want swsusp2 in 2.6. It has hooks all over
> the place:
>

but maybe that's just why it happens to work for way many more people?
Or does anyone care about that?

Fedor

PS. Sorry, just my 2 cents
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVlk3w4m50RG4juoRAt8bAJ95Xl08+o5qhbWINtjnYbMdLlpRbwCeL9n+
7d5IsT79sCTSi36oF7od6Bs=
=aIb4
-----END PGP SIGNATURE-----
