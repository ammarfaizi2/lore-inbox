Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTLIJ7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTLIJ7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:59:25 -0500
Received: from port-212-202-157-212.reverse.qsc.de ([212.202.157.212]:60907
	"EHLO bender.portrix.net") by vger.kernel.org with ESMTP
	id S264284AbTLIJ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:59:17 -0500
Message-ID: <3FD59CED.6090408@portrix.net>
Date: Tue, 09 Dec 2003 10:59:09 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209083228.GC1698@kroah.com>
In-Reply-To: <20031209083228.GC1698@kroah.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
| On Tue, Dec 09, 2003 at 08:02:19AM +0100, Andreas Jellinghaus wrote:
|
|>>Regardless of the state of udev, devfs has insolvable problems and you
|>>should not use it.  End of story.
|>
|>how many bug reports did you see in the last three months of people
|>having problems with devfs?
|
|
| I don't think that all 4 users of devfs on 2.6 are all that vocal :)
| Either way, I haven't been paying attention, as I really don't care.
|

FWIW, I've been using devfs from the beginning of 2.4 and with 2.5/2.6
with Debian and never had a problem (knock on wood). I really like the
way of having device nodes only for present devices.
Btw. I still haven't figured out, how to use udev properly. I just get
the nodes of devices I plugin after boot and of the modules I load after
boot. IDE et all aren't showing up. How early do I need to load udev or
has my kernel to be all modular for it to work properly?

Thanks,

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/1ZztLqMJRclVKIYRAlgWAJ0cFbRv2QbWrQbFNWACwHrp/opQiQCfZJVD
UjI7PkOYwt4auQb1qTRtwx8=
=40wq
-----END PGP SIGNATURE-----
