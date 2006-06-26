Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWFZOwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWFZOwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFZOwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:52:37 -0400
Received: from ns.suse.de ([195.135.220.2]:50130 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750745AbWFZOwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:52:36 -0400
Message-ID: <449FF4A5.2030006@suse.com>
Date: Mon, 26 Jun 2006 10:52:21 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Suzuki <suzuki@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ReiserFS Mailing list <reiserfs-list@namesys.com>
Subject: Re: [PATCH 03/04] reiserfs: reorganize bitmap loading functions
References: <20060615014203.GA8216@locomotive.unixthugs.org> <449FCEF7.5060202@in.ibm.com>
In-Reply-To: <449FCEF7.5060202@in.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Suzuki wrote:
> Hi,
> 
> We hit a BUG while running fsstress tests on 2.6.17-mm1. It looks like
> the BUG was introduced with this code change.

Thanks for the report, but it's known and fixed. Please apply the
patches in the mm1 hotfixes directory.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEn/SlLPWxlyuTD7IRAvwCAKCKnUI4BYWcp5ivNxWuhlljnRJU/gCcD+Nm
TFFzgbHrnx6mrIHA0faJulE=
=O7SM
-----END PGP SIGNATURE-----
