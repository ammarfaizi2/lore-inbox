Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTERMsH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTERMsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:48:07 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:11654 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262032AbTERMsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:48:05 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-mm@kvack.org>
Subject: Re: [OOPS] 2.5.69-mm6
References: <20030516015407.2768b570.akpm@digeo.com>
	<87fznfku8z.fsf@lapper.ihatent.com>
	<20030516180848.GW8978@holomorphy.com>
	<20030516185638.GA19669@suse.de>
	<20030516191711.GX8978@holomorphy.com>
	<Pine.LNX.4.50.0305162322360.2023-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0305170937350.1910-100000@montezuma.mastecende.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 May 2003 15:01:14 +0200
In-Reply-To: <Pine.LNX.4.50.0305170937350.1910-100000@montezuma.mastecende.com>
Message-ID: <87of20csth.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> On Fri, 16 May 2003, Zwane Mwaikambo wrote:
> 
> > Could you alco specify your GCC version? Your disassembly looks rather 
> > odd.
> 
> I am unable to reproduce this with DRI/AGP built into the kernel or 
> as a module. X11 Setup is Radeon 9100 w/ XFree86 4.3
> 

Radeon 7500, 64Mb video mem and Xfree 4.3.0 (-r2 in the gentoo portage
tree).

> 	Zwane

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+x4QWCQ1pa+gRoggRArLeAJkBRQskqD5HAZzto3qm39U4SSMzfgCeLhjp
iXTIR2QIIuC9a97wFQPfJVA=
=PBrp
-----END PGP SIGNATURE-----
