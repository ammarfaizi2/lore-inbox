Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUBKO3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUBKO3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:29:06 -0500
Received: from ns2.len.rkcom.net ([80.148.32.9]:31661 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S261411AbUBKO3D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:29:03 -0500
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 99% System load
Date: Wed, 11 Feb 2004 14:30:15 +0000
User-Agent: KMail/1.6
References: <200402111423.02217.ma1flfs@bath.ac.uk>
In-Reply-To: <200402111423.02217.ma1flfs@bath.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402111430.24327.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday February 11 2004 14:22, Florian Schanda wrote:
> The strange thing is, resuming the build after the reboot with exactly the
> same command (make -j4) will work fine... It's just not reproducible at
> all, but it happend often enought to make it annoying.

To add to this, if I do a simple "make" just now (without having rebooted) I 
end up with another unkillable process.

	Florian Schanda
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKjx3fCf8muQVS4cRAky8AKCdColeD7zjMnhpO5DINGDr2unQygCfe4hX
zm83dOBXU8QphGm6JYuLAic=
=wh/b
-----END PGP SIGNATURE-----
