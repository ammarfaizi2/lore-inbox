Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWBSVwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWBSVwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWBSVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:52:04 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:50905 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S1750711AbWBSVwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:52:03 -0500
Message-ID: <43F8E87C.1000409@kalifornia.com>
Date: Sun, 19 Feb 2006 13:51:56 -0800
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: George P Nychis <gnychis@cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with unloadable module support... SMP
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>    <20060219191552.GB4971@stusta.de> <46653.128.237.252.29.1140384421.squirrel@128.237.252.29>
In-Reply-To: <46653.128.237.252.29.1140384421.squirrel@128.237.252.29>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

George P Nychis wrote:
> Okay, I downloaded the 2.6.16-r4 kernel and left it unmodified and I do
not get the panic.
>
> Can you suggest anything for me so that I can find what is causing the
panic with the gentoo vanilla sources?

Gentoo doesn't understand the concept of "vanilla" packages.  Make a
practice of downloading your kernel directly from kernel.org and
building it yourself.

Out of 10+ boxes that I've run on Gentoo, only one has worked using
the Gentoo kernel.


- -b
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+Oh6InEozL1f7FIRAroHAJ4wofnOlA9ZvaWCsayVVWVPK6KBAwCfZTek
jrMGs3ZvBIrczj32xHhEjLM=
=9OUS
-----END PGP SIGNATURE-----

