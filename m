Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVDNCxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVDNCxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 22:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDNCxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 22:53:54 -0400
Received: from main.gmane.org ([80.91.229.2]:58567 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261244AbVDNCxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 22:53:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: bd <bdonlan@bd.beginyourfear.com>
Subject: Re: [ANNOUNCE] git-pasky-0.3
Date: Wed, 13 Apr 2005 19:05:26 -0400
Message-ID: <o6l0j2-7qq.ln1@bd-home-comp.no-ip.org>
References: <20050409200709.GC3451@pasky.ji.cz>	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>	 <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>	 <1113311256.20848.47.camel@hades.cambridge.redhat.com>	 <20050413094705.B1798@flint.arm.linux.org.uk>	 <20050413085954.GA13251@pasky.ji.cz>	 <1113384304.12012.166.camel@baythorne.infradead.org> <1113396229.17538.134.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: student70.mssm.org
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
In-Reply-To: <1113396229.17538.134.camel@gonzales>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Xavier Bestel wrote:
> Le mercredi 13 avril 2005 à 10:25 +0100, David Woodhouse a écrit :
> 
>>On Wed, 2005-04-13 at 10:59 +0200, Petr Baudis wrote:
>>
>>>Theoretically, you are never supposed to share your index if you work
>>>in fully git environment. 
>>
>>Maybe -- if we are prepared to propagate the BK myth that network
>>bandwidth and disk space are free. 
> 
> 
> On a related note, maybe kernel.org should host .torrent files (and
> serve them) for the kernel git repository. That would ease the pain.

Bittorrent does not lend itself well to frequently-changing files or
collections thereof - each time the git repository ip updated, a new
metadata file would need to be created, and distributed, and you'd lose
all the seeds who don't bother to get the new one every time it changes.
Moreover, I imagine some clients would have problems with more than 900
or so files due to open file limits.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iQIVAwUBQl2lsXhF4rlE0/81AQMEZA/+MtAwhLVBGbjIGMG4911/Q4tL+RZCni2Z
9wCM2/1Acca7CUeYJOX3bFqx/HMlVyzTN/DFyz7oQbngNrcOFaO4xqHwDT9iVpUB
x1fE2Ct1BXOOnAQEzjEoogKrjWuYiy2tkcsFNMFoef0qV9U8olwwtUgXG8+dOQSZ
gEPocjFmEJLMxhNxdnigW2R1KWgJ0IoFmpIWxDUnpQGBg/dfVxtI4EQhR7FgZwch
O9faPyMdHEct7WW4S8ysMcwGUyRg8J/nlgt413P66PSp9IJ5u8t/gUc0vVcDR0Bl
QNO5Hf2kGe/tILYNMJOtQX8sGcKHC4mZJMsNlhs5Y0+GsD9/9JGj3lv69SM+kv92
5S3ePfArzNvnuoCCxS1iC+s1HZ8fyYXAPx6pVA3cs0/+QGv0LjeSZOCBWmh8vrl1
SD4MF6TPy4mdF1corQE1o8bCc/VP0cTnwBvyF6BpZeP9nipgrzLxM1PPTtDjyUDG
B3VocEsieTyyzfl3hXJxGqFL3Txt6EbRU4AwYitONbTU5zMaQuEY4xBD+UWQJgAO
K8rMXqONSoORWrZVuRyrTmFr/z6zq00BpwQy7BbHuwEXHSPvc/e4UHtk8wNYyY13
LAi2jgMGmGckwucauqZY5Y3mDaOh2m9+0x8hIvvnmLPQC91cVsuerKiKYzjYJ4/4
qsnhjobIq1s=
=ZiJ1
-----END PGP SIGNATURE-----

