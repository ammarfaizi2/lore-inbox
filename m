Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVAJAax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVAJAax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVAJAax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:30:53 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:60607 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261986AbVAJAan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:30:43 -0500
Message-ID: <41E1CCB7.4030302@comcast.net>
Date: Sun, 09 Jan 2005 19:30:47 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv>	 <41DD9968.7070004@comcast.net>	 <1105045853.17176.273.camel@localhost.localdomain>	 <1105115671.12371.38.camel@DreamGate>  <41DEC5F1.9070205@comcast.net>	 <1105237910.11255.92.camel@DreamGate>  <41E0A032.5050106@comcast.net> <1105278618.12054.37.camel@localhost.localdomain>
In-Reply-To: <1105278618.12054.37.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alan Cox wrote:
|>I'm claiming that an IT infrastructure that has to support 2.6 as-is
|>will be wildly more complex and more expensive than one supporting a
|>truly stable one with the same efficiency.  It keeps changing.  New
|>features must be added that aren't amply tested (and due to the 2.6
|>development structure, ample testing before mainline integration is much
|>more difficult).
|
|
| Large IT businesses already deployed 2.6 (SuSE) and will do so more soon
| (Red Hat). These vendors are guaranteeing long term stable maintenance
| of those versions.
|
|
|>Ask Linus to start making 3rd party binary module support a reality then.
|
|
| Binary module support is pretty irrelevant. Good management of out of
| tree source code recompiling is a much more useful and relevant topic.
| 2.6 has caused an inadvertent problem there because with 2.4 it was
| *much* easier to grab 2.4.x and drop in a 2.4.y version of a driver.
|
|

And what 3rd party hardware vendor wants to waste their resources by
repeting smaller versions of the one-time cost of driver writing over
and over to accomodate linux, when they can't even accomodate all
versions due to special patches some people have?  So far there's been a
rediculous but visible trend of hardware vendors to hold their source
closed.  Why not just chase the easier targets like Windows and MacOS?

I want Linux to be a popular OS.  Linus I wouldn't be surprised if he
doesn't care, because Linux isn't a business (though some businesses are
for all intents and purposes basically Linux), so this is pretty much a
moot point to be arguing.  Anything having to do with the marketability
of Linux is pretty much not worth arguing; genuine quality in the open
source community tends to be, though only if it encompasses only
contributions from the open source community.

I guess this isn't worth bothering to argue anymore.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4cy2hDd4aOud5P8RAuJmAKCJ29DIvWuqPLhRvmn+IRdvroNcRgCfU1qD
rcuho2zJTLnH9CMt7urYfyM=
=eCh6
-----END PGP SIGNATURE-----
