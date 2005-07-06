Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVGFUtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVGFUtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVGFUki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:40:38 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:63587 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262528AbVGFUjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:39:22 -0400
Message-ID: <42CC4177.9020607@suse.com>
Date: Wed, 06 Jul 2005 16:39:19 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: [PATCH 2/3 (updated)] openfirmware: add sysfs nodes for open
 firmware devices
References: <20050706192627.GA17492@locomotive.unixthugs.org> <Pine.LNX.4.58.0507061241010.3570@g5.osdl.org> <Pine.LNX.4.58.0507061317250.4114@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507061317250.4114@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Wed, 6 Jul 2005, Linus Torvalds wrote:
>>Can you re-send the other ones too, and I'll apply the whole series.
> 
> Ok, I've applied it, but it seems to make my X installation really really 
> unhappy on my G5.
> 
> I'm trying to hunt down the reason (no oopses, at least).

Hrm. These patches always get more fun. What behavior are you seeing?

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCzEF3LPWxlyuTD7IRAq5eAJ47cVtkcucNFRzyVSfH1oRRyupQKgCeJemA
0cogMr5PHPrRvted/jqhbjc=
=a1rB
-----END PGP SIGNATURE-----
