Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTHQUDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbTHQUDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:03:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:56554 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S270681AbTHQUDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:03:06 -0400
From: Patrick Dreker <patrick@dreker.de>
To: Jussi Laako <jussi.laako@pp.inet.fi>,
       Alistair J Strachan <alistair@devzero.co.uk>
Subject: Re: nforce2 lockups
Date: Sun, 17 Aug 2003 22:02:40 +0200
User-Agent: KMail/1.5.9
Cc: Clock <clock@twibright.com>, kenton.groombridge@us.army.mil,
       linux-kernel@vger.kernel.org
References: <df962fdf9006.df9006df962f@us.army.mil> <200308151738.08965.alistair@devzero.co.uk> <1061148472.1459.3.camel@vaarlahti.uworld>
In-Reply-To: <1061148472.1459.3.camel@vaarlahti.uworld>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200308172202.47521.patrick@dreker.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Sunday 17 August 2003 21:27 schrieb Jussi Laako <jussi.laako@pp.inet.fi> 
zum Thema Re: nforce2 lockups:
> On Fri, 2003-08-15 at 19:38, Alistair J Strachan wrote:
> > > NFORCE2: chipset revision 162
> > I use APIC and ACPI on my EPoX 8RDA+, and I've never had any IO problems.
> > So it seems unlikely that it is tied to a chipset revision.
>
> I have ASUS A7N8X Deluxe mobo with nForce2 rev 162 without any problems
> (if not counting unability to enabe SiI SATA DMA mode with attached
> Seagate Barracuda drive).

I have the exact same Board (except I'm not using SATA), and it's a nightmare. 
Best uptime so far: a little more than 16 hours. Usually it locks up a lot 
earlier. When I do network transfers I can cause it to lock within a few 
minutes. Under "the other OS" it runs without any problems.

- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/P99ncERm2vzC96cRAkl3AJ9XG9ShZVlQXqyupyhz08EHNdiPiwCgj/ji
W++fbQC3hOVBvR6xCgV7V6A=
=HVPf
-----END PGP SIGNATURE-----
