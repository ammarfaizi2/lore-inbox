Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267830AbRGUWDh>; Sat, 21 Jul 2001 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267831AbRGUWD1>; Sat, 21 Jul 2001 18:03:27 -0400
Received: from L0190P28.dipool.highway.telekom.at ([62.46.87.188]:57730 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S267830AbRGUWDO>;
	Sat, 21 Jul 2001 18:03:14 -0400
Date: Sun, 22 Jul 2001 00:02:03 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Another 2.4.7 build failure
Message-ID: <20010722000203.A25593@aon.at>
In-Reply-To: <20010721222826.A1953@lucretia.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010721222826.A1953@lucretia.debian.net>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 10:28:26PM +0200, you wrote:
> Building fails for me with following error:
> ll_rw_blk.c:25: linux/completion.h: No such file or directory

Maybe a bad patch?
$TOPDIR/include/linux/completion.h exists, at least on my platform :)

regards, alexx
-- 
|   .-.   | Alexander Griesser <tuxx@aon.at> -=- ICQ:63180135 |  .''`. |
|   /v\   |  http://www.tuxx-home.at -=- Linux Version 2.4.7  | : :' : |
| /(   )\ |  FAQ zu at.linux:  http://alfie.ist.org/LinuxFAQ  | `. `'  |
|  ^^ ^^  `---------------------------------------------------´   `-   |
