Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVBPNmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVBPNmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 08:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVBPNmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 08:42:03 -0500
Received: from mail.pixelwings.com ([194.152.163.212]:51082 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id S262007AbVBPNkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 08:40:37 -0500
Message-ID: <42134D4A.6010005@tequila.co.jp>
Date: Wed, 16 Feb 2005 22:40:26 +0900
From: Schwaighofer Clemens <cs@tequila.co.jp>
Organization: =?ISO-8859-1?Q?TEQUILA=A5Japan?=
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@arm.com>
CC: kernel@crazytrain.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com>	<58cb370e05021404081e53f458@mail.gmail.com>	<20050214150820.GA21961@optonline.net>	<20050214154015.GA8075@bitmover.com>	<7579f7fb0502141017f5738d1@mail.gmail.com>	<20050214185624.GA16029@bitmover.com>	<1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp> <tnx7jl824b3.fsf@arm.com>
In-Reply-To: <tnx7jl824b3.fsf@arm.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Catalin Marinas wrote:
| Clemens Schwaighofer <cs@tequila.co.jp> wrote:
|
|>On 02/15/2005 09:19 PM, kernel wrote:
|>
|>>With all of the complaining about BK you'd think there'd be an equal
|>>alternative.
|>
|>there is no need for that. There is already one. Subversion is a more
|>than mature VCS. Apache group is switching to it, gcc people are
|>strongly thinking about it, and those two are _huge_ projects with tons
|>of developers, patches, trunks, etc.
|
|
| Subversion and BK are quite different. The first one is snapshot
| oriented and the latter is changeset oriented (I find this a more
| powerful concept). Subversion is not distributed (you have some helper
| scripts but I don't know how stable they are), which is somehow
| mandatory for the way Linux is developed. Subversion also lacks any
| smart merging capabilities (it doesn't even remember what was
| merged).
|
| GNU Arch is probably as close as you can get regarding features and
| performance (I can't compare the two since I've never used BK).

well yes, I never searched for a distributed VCS, thats why I never
tried GNU Arch not so much (but I have to say, that it has hyper complex
command line options, perhaps darcs might be better).

Furthermore I sadly have to admit that I don't know the exact difference
between snapshot and changeset oriented. I just know that subversion has
~ Atomic comits and it works more than fine for me :)

Perhaps somebody can point me out to some Documentation about that (can
be in PM and not to the list)

lg, Clemens

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCE01KjBz/yQjBxz8RAgumAKDPg8I0hJU+rs/UIb0wRcgQy2dPOwCcDy6g
4994vMzy66WeTuB/fArYgMY=
=Nyim
-----END PGP SIGNATURE-----
