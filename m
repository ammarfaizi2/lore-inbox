Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVAGFs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVAGFs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 00:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVAGFs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 00:48:56 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:39148 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261249AbVAGFsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 00:48:52 -0500
Message-ID: <41DE22BC.3080500@comcast.net>
Date: Fri, 07 Jan 2005 00:48:44 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       Rik van Riel <riel@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com> <20050103153438.GF2980@stusta.de> <1104767943.4192.17.camel@laptopd505.fenrus.org> <20050104174712.GI3097@stusta.de> <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com> <20050106193510.GL3096@stusta.de> <Pine.LNX.4.60.0501061737100.12680@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.60.0501061737100.12680@dlang.diginsite.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



David Lang wrote:
| On Thu, 6 Jan 2005, Adrian Bunk wrote:
|

[...]

| remember that according to some people 2.6.0 wasn't supposed to support
| anything compiled in, everythign was going to be a module, with much of
| the hardware detection removed from the kernel and put into code running
| on initrd or similar.

I'm told Linus refuses to do anything that would help establish and
support binary drivers, even if someone else does the work for him and
doesn't cause any bugs or interfere with the other systems inside the
kernel.

I'm not sure if this is true or not, but moving to modules-only sounds
like a good first step to "Hey, let's do binary drivers to get third
party support and become a real competing desktop OS"  "Hey, let's do
binary drivers"  "Hey, let's do binary drivers"  "SHUT THE HELL UP"
"But hey man, binary drivers, we're already at all modules for drivers"
~ "Hey, binary drivers"  "ALRIGHT FINE *grumble*"

Not that I don't fully support closed-source binary drivers as a way to
get hardware working until better, cleaner, open source alternatives
show up, mind you. . . :)

[...]

|
| David Lang
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3iK7hDd4aOud5P8RAibaAJ97SIihv6jFh1Pxs8X/KmmgtEEJfgCaAqby
DszwpF70zEwKh15Sbj+YzqI=
=j75D
-----END PGP SIGNATURE-----
