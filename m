Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUG0DoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUG0DoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUG0DoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:44:05 -0400
Received: from smtp4.cwidc.net ([154.33.63.114]:52388 "EHLO smtp4.cwidc.net")
	by vger.kernel.org with ESMTP id S266241AbUG0Dnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:43:52 -0400
Message-ID: <4105CF6A.8070504@tequila.co.jp>
Date: Tue, 27 Jul 2004 12:43:38 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040724
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Joel.Becker@oracle.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org> <cone.1090882721.156452.20693.502@pc.kolivas.org> <4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp> <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au> <cone.1090896213.276247.20693.502@pc.kolivas.org> <Pine.LNX.4.53.0407271250210.23847@tellurium.ssi.swin.edu.au>
In-Reply-To: <Pine.LNX.4.53.0407271250210.23847@tellurium.ssi.swin.edu.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Connors wrote:
| On Tue, 27 Jul 2004, Con Kolivas wrote:

| Then there's the relative importance of subjective "feel", vs hard
| numbers. Maybe some people prefer that their system feels nicer, even if
| it doesn't compile kernels so fast. And I think this decision is best left
| to at least one of those knobs (hey, all you know, people might even
| adjust the knob in a crontab).

I think, the more linux users are out there, the less is the percentage
who compiles kernels often. And often means once or twice a day. Most
people use stock kernels. I think a "knob" that says "compile a lot" or
"normal" or "server" or so would be nice.

Especially because a server has very different need of swap, etc than a
workstation.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBc9qjBz/yQjBxz8RAqrJAKDkBo7ZnYzWOqdXABRUPYUoO1ooSACffSnk
uTERz/dQaEV1lSUsCEdsRhk=
=EBxd
-----END PGP SIGNATURE-----
