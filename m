Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVCTXXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVCTXXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVCTXVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:21:10 -0500
Received: from 63.reserved.callplus.net.nz ([203.184.21.63]:7437 "EHLO
	brick.flying-brick.caverock.net.nz") by vger.kernel.org with ESMTP
	id S261345AbVCTXRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:17:30 -0500
Date: Mon, 21 Mar 2005 11:17:21 +1200
From: viking <viking@flying-brick.caverock.net.nz>
To: linux-kernel@vger.kernel.org
Subject: Kernel hiccups (was USB Mouse Hiccups)
Message-ID: <pan.2005.03.20.23.09.09.100611@brick.flying-brick.caverock.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Flying Brick Systems
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Pan-Internal-Attribution: On Sun, 20 Mar 2005 23:20:04 +0100, viking wrote:
X-Pan-Internal-Sendlater-To: linux-kernel@vger.kernel.org
X-Pan-Internal-Post-Server: news.individual.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005 23:20:04 +0100, viking wrote:

-blather-
> at least I *think* they're Linus' patches - no Visual Basic in them yet.
Guess that means Linus hasn't flipped his lid. So we won't see Linux-4.0
for MSVC any time soon.

Heh he - the ultimate virus would be if a Linux kernel could install
itself onto a NTFS partition and take over from the Windows kernel code.
Then MS would have way less support issues, we'd be hailed saviours, and
achieve world domination through the back door.

-meat-
> I've also noted .10 is quicker off the blocks than 2.6.11 seems to be.

Namely seems to happen around the times when I'm doing something like
mounting devfs (takes nearly 30 secs), and when I'm accessing files from
disc (bash$ less some-random-file.txt) - this can take about two seconds
for Linux to actually notice I've done something. I've no idea where the
error is here, either. i.e. is bash waiting around for me? is the
filesystem code waiting for some reason? Is the kernel in a tailspin?
[shrug]

CC if you wish, but I ought to be watching the list again for this one.

-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!
