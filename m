Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTJWPsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJWPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:48:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:12260 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263595AbTJWPsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:48:46 -0400
From: Oliver Bohlen <oliver.bohlen@t-online.de>
Reply-To: oliver.bohlen@t-online.de
Organization: Deutsche Telekom AG
To: linux-kernel@vger.kernel.org
Subject: Resume after suspend
Date: Thu, 23 Oct 2003 17:51:30 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310231751.30884.oliver.bohlen@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi!

I'm using the kernel 2.6test8 from kernel.org with apm on my Laptop.
If I have X started I can't resume when suspend is finished. It's working 
without X. 
Is there any problem with the kernel, apm and X? 
Here some informations about my system:

Hardware:
Gericom Webgine XL Force
P4@2,4GHz
512 MB of RAM
nVidia GeForce 4 Go (32 MB memory)
BIOS supports APM and ACPI

Software:
Gentoo Linux
Kernel 2.6test8 from kernel.org
apmd-3.0.2-r3

Suspend with ACPI is with "echo 3 > /proc/acpi/sleep" working but I can't 
resume. Here it is the same with and without X.
I tried to get help in several other Mailinglists but the problem isn't solved 
yet.

Is here anyone who can help me?

Thanks
Olli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUBP5f5Alb2+hVV5H1AAQKrsgf+KyQvDa4xUUsz6Ydftft7Slk2E1Phm+CW
L42F79UolRnkw6U1LyhAHcWRpzRXgHfZ2ubT5XW6KTcuJ4UOHd15pv0CWFnXL+kA
eEFA9H8RQIyM+96GD1MWBBR2E3C00w2ANamUHQjgUG7q8inlMsh9YV0eVqDe5J08
inEEHpMtpgeNLsE1H/Z0LldAT/pdeSYe9iZ+NL2pvVbXhJvyo2PYxjx8isXqmS2w
Vm5dpl8o9qcRNVz61Z5CH4XghFOuXrg1Wt+pMiwsn4vVhppdAgoD6OBcwSvAiRHC
RdZe/HMbtsToKPJMwhExjwrnENKqFWn1GwowIywY5xmKWonJzy1CrA==
=DIs1
-----END PGP SIGNATURE-----

