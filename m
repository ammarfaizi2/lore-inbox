Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTELF2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 01:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTELF2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 01:28:49 -0400
Received: from stingr.net ([212.193.32.15]:31957 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id S261927AbTELF2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 01:28:48 -0400
Date: Mon, 12 May 2003 09:41:30 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Two RAID1 mirrors are faster than three
Message-ID: <20030512054130.GA1318@stingr.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <200305112212_MC3-1-386B-32BF@compuserve.com> <3EBF24A8.1050100@tequila.co.jp> <1052716203.4100.10.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1052716203.4100.10.camel@tor.trudheim.com>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Replying to Anders Karlsson:
> downtime on it. You then quiesce the database, split off the second copy
> from the mirror, mount that as a separate filesystem and back that up
> while the original with its first copy has already stepped back into
> full use.

Why do not use snapshots for this?
- -- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
-----BEGIN PGP SIGNATURE-----

iD8DBQE+vzQCyMW8naS07KQRAnDBAKC9+yL2chK4eIldN8KiGQRIA5VkEQCfadZH
GMYbeKYtHmQ7p9rEBqlxmmA=
=0CCn
-----END PGP SIGNATURE-----
