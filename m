Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTELFIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 01:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTELFIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 01:08:20 -0400
Received: from [195.95.38.160] ([195.95.38.160]:33526 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S261917AbTELFIS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 01:08:18 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.420] Unexplained repeatable Oops
Date: Mon, 12 May 2003 07:21:37 +0200
User-Agent: KMail/1.5.1
References: <200305112052.51938.devilkin-lkml@blindguardian.org> <200305120739.30154.kernel@kolivas.org>
In-Reply-To: <200305120739.30154.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305120721.43384.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 May 2003 23:39, Con Kolivas wrote:
> On Mon, 12 May 2003 04:52, DevilKin-LKML wrote:
> > On my main machine at home I have encountered since this morning an Oops
> > that never happened before. It happened when I was playing a game of
> > Diablo II through Winex (yes, with the Nvidia modules loaded and stuff
> > loaded from VMWare). This oops I didn't bother to capture, since I know
> > that oops'es from a tainted kernel are not accepted.
> > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> > (rev 40) Subsystem: ABIT Computer Corp.: Unknown device a702
> >         Flags: bus master, stepping, medium devsel, latency 0
> >         Capabilities: [c0] Power Management version 2
>
> Good old VIA chipset. I solved a similar problem by underclocking a cpu on
> a similar chipset :-(
>
> Try the mprime client stress test to ensure your hardware is ok.
> www.mersenne.org

Ah.
Strange thing is that it has worked perfectly for atleast a year, problems 
only started yesterday morning while I was doing what I've done a zillion 
times before...

I will check anyhow.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vy9kpuyeqyCEh60RAolSAJ9Kc/WY2W86XS8NNPaP0I624SnptQCfT5GM
wQD1XDMcGLv2mAs2pwQHliw=
=uGeS
-----END PGP SIGNATURE-----

