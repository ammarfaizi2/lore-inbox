Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWEAJmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWEAJmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWEAJmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:42:39 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:15760 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750984AbWEAJmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:42:39 -0400
Message-ID: <4455D7E7.1040203@dgreaves.com>
Date: Mon, 01 May 2006 10:41:59 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, nickpiggin@yahoo.com.au
Subject: Re: Bad page state in process 'nfsd' with xfs
References: <4452797F.70700@dgreaves.com> <20060501080427.H1771752@wobbly.melbourne.sgi.com>
In-Reply-To: <20060501080427.H1771752@wobbly.melbourne.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nathan Scott wrote:
> Hi there,
>
> On Fri, Apr 28, 2006 at 09:22:23PM +0100, David Greaves wrote:
>
> But, the warning is triggered by the page count (16777216 above), and
> that is 0x1000000 -- which is a huge, improbable count; that looks to
> me like it could very well be the result of a single bit error too.
>
> You may have a hardware problem - try running memtest I guess.
Thanks guys

It's in use a lot so I'll  schedule some downtime, blow out the dust
and run memtest (though I've done that before and it has been clean).

I'll let you know how it goes...

David

- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEVdfn8LvjTle4P1gRAiHTAKCBakrWQCpHgo8qyfN6ZNryAxi3bQCdFkDn
vQe781l5bQvq1a5BG2nF5sk=
=jdAy
-----END PGP SIGNATURE-----

