Return-Path: <linux-kernel-owner+w=401wt.eu-S1761978AbWLIUKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761978AbWLIUKI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761982AbWLIUKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:10:07 -0500
Received: from alnrmhc12.comcast.net ([206.18.177.52]:60717 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761978AbWLIUKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:10:06 -0500
Message-ID: <457B181C.3010305@comcast.net>
Date: Sat, 09 Dec 2006 15:10:04 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Kyle McMartin <kyle@ubuntu.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: noexec=on doesn't work
References: <457B0FD7.2030804@comcast.net> <20061209200323.GA21514@athena.road.mcmartin.ca>
In-Reply-To: <20061209200323.GA21514@athena.road.mcmartin.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Kyle McMartin wrote:
> On Sat, Dec 09, 2006 at 02:34:47PM -0500, John Richard Moser wrote:
>> I have filed this as a distro bug with Ubuntu; it may be their issue, I
>> haven't dug deep enough to find out.  I am posting this here to disperse
>> the information breadth-first instead of depth-first, which will shorten
>> the bug's life cycle if it turns out to be an upstream bug.
>>
> 
> NX requires the 64-bit page table entries (ie, PAE) which requires
> CONFIG_HIGHMEM64G.
> 

Thanks.

> Why are you posting to linux-kernel@ without even checking the upstream
> kernel, anyway?
> 

Because I had no real clue how to do that and didn't have enough
information to fill in why it wouldn't work.  It also showed up on
Gentoo so I took that as close enough.  :)

Sorry.  :)

> plonk.
> 
> 	Kyle M.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXsYGgs1xW0HCTEFAQKiqQ/+Ksb3v2gptqaYbCDIJgG723e2DT/Waz26
MtlvxJVPhkHB7JcFFsCojeLNj5rkvaZhuf1VOUfWjiRh9qi9PgrfGWcdBVUacdnK
gAmdoRTlxobID+HajrWT6kGx5P64XkccZJxMVD59yXbxLzAp8NAus21UbeYcdHsF
hCDCNjj6CcUF02hl/Nm1y1I3/rmh4T6hfR0AW/NpkR9Z01GgRkUDvGmsZESNRovA
kXmfjN7i7b/qH48619o+NivHXEUQK0orHAqV8EOoeF4D5TAewoJBNxUffGdWt20E
diOY21awg66gTxEqWA/Owd2DasrHmZ2WcI+73bade1wr2NR7thTtQNoCvqR/0AZK
l+2GE7E9Hreiay8aMLtZNW8DxIE0PpMA+PJPgwVZFbKLOb1x2VqXljSg1djUGjkJ
O2WtSdNNIL04LQkh8ffJTq7eozZfNjT8e/ctKYk/OvaBso8GQbpJVxr/GVYGmQzW
EOA9uAVaJeRBm7KHud/ExOI0PDxQbJfVF/zo5NdY/kV8mJPhSuR97s11+3XUOwrK
uqlRwA6k3cEoPP3tmi6nZ70oq9lTWMl+v05dESAu3r1J6FBSMMXfU6OUHjIKDwkY
MM5762xuNTsfuePtA9LrXzCMruU31rHIFxcWu1b8M/elJ/D4puBkp2SBxu7AIvdZ
ara7KkuWPJE=
=OplU
-----END PGP SIGNATURE-----
