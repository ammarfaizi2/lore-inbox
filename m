Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWJLPxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWJLPxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422722AbWJLPxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:53:12 -0400
Received: from alnrmhc12.comcast.net ([206.18.177.52]:60656 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1422721AbWJLPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:53:10 -0400
Message-ID: <452E64E4.4090303@comcast.net>
Date: Thu, 12 Oct 2006 11:53:08 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net>
In-Reply-To: <452E62F8.5010402@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



John Richard Moser wrote:
...
> The second is, if it IS possible to get faster context switches in
> general use, can the L4 context switch methods be used in Linux?  I
> believe L4 is BSD licensed-- at least the files in their CVS repo that I
> looked at have "BSD" stamped on them.  Maybe some of the code can be
> examined, adopted, adapted, etc.
> 

Looking a bit deeper, Iguana is OzPLB licensed, oops.  :(

The question still remains, though, as to what must happen during
context switches that takes so long and if any of it can be sped up.
Wikipedia has some light detail...


- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS5k4gs1xW0HCTEFAQIzYxAApoMBD2Oo9GwYFurgwjAAxwaikHcAIeXI
14Defpeb863KguvMSk698+O1HuwhJlMfMw6Ir1pKvLS85ooPpUXSsV1SMRG27fNY
GsHdoIFgBJiAeokrYdXfmGE8HZvnAvVBNPrPik9F7OfglptEe1kMXQ4gbqCzWUq0
qVWE6/X8UqaTw3M1fDS7+uebq1Mc4aafCIf6ANRRxzrz4TQzeIs4EWuy9x8wjuF9
laBV9xrIghXKf+vcstgLbkLdalBvfBpIWHaD5qbZk7G6nRzJrZeKCThn4zivylzZ
3W6xUu5U4fZyKiMbGiZNqnJa7ym9z15LPIHlVZ4R2uZkjT4fv70Hd1zh9frWWCqI
4Nw0RWz3DWtTi17CgTgprRM/TGN4MEnU+DFo6noPqCpxSdNn+LsKP8e+lpgZxql9
Vj3KvFl7uUI3Bp/PWdp8f6if/DyhXbrYkb9Dp/SY68tVAiffkfPrwgtCHpmAVGqZ
NtdpwRYQgsMH3VMB0zJDJOG3zxmP4l/X/ay8zPBmd+elItR3OPHu4rcnlDYwgK3x
TyIaAzyC175nTRgyA3ZkuN1JWHEnFOj3LDMlSFOlSiqMu37ncNocPbLb+L/papt+
GIxFO4eYR/D6X9N2lr1UXCxyDljMD7Y0fWc7667QN7eGH7jqaiIg8FYq3uUt7jZc
6Gdh7sZXIMg=
=vdRP
-----END PGP SIGNATURE-----
