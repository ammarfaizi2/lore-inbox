Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVA0S5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVA0S5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVA0S4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:56:55 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:31681 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262705AbVA0SzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:55:07 -0500
Message-ID: <41F93926.4090401@comcast.net>
Date: Thu, 27 Jan 2005 13:55:34 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <Pine.LNX.4.58.0501271018510.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271018510.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Thu, 27 Jan 2005, Linus Torvalds wrote:
> 
>>Real engineering is about doing a good job balancing different issues.
> 
> 

[...]

> test. Maybe such a vendor understands that you have to ease into things, 
> and you can't just say "this is how it has to be done from now on".
> 

My idea of "Easing into things" is dropping the full model in the guy's
face and saying "Here, this is what we want to do.  It's there, you
don't have to use it, but you should be mindful because it's better and
in the future people will want it."  Then people will wait to turn it on
until everything is written to work with it--and every developer will
see it and know that that is there and that certain things need to be done.

You don't have to beat them with a crowbar until they listen, but you
have to show them what they're supposed to do.

> 			Linus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+TklhDd4aOud5P8RArG1AJ48Sno5o0MywWKcwFIF2n8GapOLrACffZDG
KzNjlsb8m2DWVaPEt+yfQ+k=
=BBA9
-----END PGP SIGNATURE-----
