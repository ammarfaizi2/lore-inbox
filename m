Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTEVVIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTEVVIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:08:23 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:33288 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S263298AbTEVVIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:08:20 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm8
Date: Thu, 22 May 2003 23:21:15 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030522021652.6601ed2b.akpm@digeo.com> <3ECCBD6B.9070807@aitel.hist.no>
In-Reply-To: <3ECCBD6B.9070807@aitel.hist.no>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305222321.26880.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 22 May 2003 14:07, Helge Hafting wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.
> >69-mm8/
> >
> > . One anticipatory scheduler patch, but it's a big one.  I have not
> > stress tested it a lot.  If it explodes please report it and then boot
> > with elevator=deadline.
> >
> > . The slab magazine layer code is in its hopefully-final state.
> >
> > . Some VFS locking scalability work - stress testing of this would be
> >   useful.
>
> It seems to work fine for UP and survives a kernel compile.

also for me, UP no preempt and it is running for 11 hours now without 
problems. It survived a kernel compile, compilation of the kde-network 
package and every other normal desktop-system usage. 

	Rudmer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+zT9ShvANkaSdp/IRAh/IAJ4wuUoONk96noYpbLJOBbhvDsmNwwCeKsNa
S9VGQ6HCiwrlQJv2rEjOBMA=
=386g
-----END PGP SIGNATURE-----

