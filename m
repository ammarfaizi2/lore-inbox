Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTILXHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTILXHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:07:47 -0400
Received: from smtp1.globo.com ([200.208.9.168]:13204 "EHLO mail.globo.com")
	by vger.kernel.org with ESMTP id S261928AbTILXHh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:07:37 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Fri, 12 Sep 2003 20:07:23 -0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309122007.35542.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox escreveu:

> It isnt that simple, unfortunately you need an NDA for the full story.
> If you want to check which chips need it get a setup that hangs reliably
> with large transfers, put the same disks on a newer controller that
> doesnt and see what happens

So, shouldn't we go back to my suggestion? A lot of users won't know that this 
limit is being set and telling them on boot time would be a good thing I 
think.

And I still don't know how to set this limit back to 128 with 2.6.x kernels. 
It can't be done the same way as in 2.4.x, can it?

Marcelo Penna Guerra
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YlGyD/U0kdg4PFoRAiHdAJ97opZnlt0uVKh+GVERMtKbH4HmWACgj21x
0zSI4+LRkBs3Dz6gDvdilIU=
=Saft
-----END PGP SIGNATURE-----
