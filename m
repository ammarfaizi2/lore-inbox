Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUJVWyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUJVWyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJVWyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:54:39 -0400
Received: from dev.tequila.jp ([128.121.50.153]:40206 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268294AbUJVWyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:54:03 -0400
Message-ID: <41798F74.9090200@tequila.co.jp>
Date: Sat, 23 Oct 2004 07:53:40 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/23/2004 07:05 AM, Linus Torvalds wrote:
> Ok,
>  Linux-2.6.10-rc1 is out there for your pleasure.
> 
> I thought long and hard about the name of this release (*), since one of
> the main complaints about 2.6.9 was the apparently release naming scheme. 
> 
> Should it be "-rc1"? Or "-pre1" to show it's not really considered release
> quality yet? Or should I make like a rocket scientist, and count _down_
> instead of up? Should I make names based on which day of the week the
> release happened? Questions, questions..

rc is release candidate. Which means its close to a release. Shouldn't
this be more a -test? -pre? count down? -rc-1 ? is this -1 or dash 1? :)

Well I think better stick with the count up way ...

Or is the time come, where the shall be a split to a real dev line ...

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBeY90jBz/yQjBxz8RAq8/AKC211LmAE2UkvAGIX/vkR+9ILAWgQCfQk1A
oIcOhIKixDUfjUo4DpokfYw=
=6UyI
-----END PGP SIGNATURE-----
