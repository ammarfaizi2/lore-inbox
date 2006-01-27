Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWA0IPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWA0IPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWA0IO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:14:59 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:49579 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932314AbWA0IO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:14:59 -0500
Message-ID: <43D9D681.7020002@namesys.com>
Date: Fri, 27 Jan 2006 00:14:57 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Edward Shishkin <edward@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4,
 unixfile) vs (reiser4,cryptcompress)
References: <43D7C6BE.1010804@namesys.com> <43D7CA7F.4010502@namesys.com> <20060126153343.GH4311@suse.de> <43D91225.3030605@namesys.com> <20060126185612.GM4311@suse.de> <43D933EB.6080009@namesys.com> <20060127080625.GS4311@suse.de>
In-Reply-To: <20060127080625.GS4311@suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> So the systime quoted above is basically useless, it doesn't reflect the
>
>real time spent in the kernel by far. I think you should note that when
>you post these scores, otherwise you're really showing a skewed picture.
>
>  
>
He wasn't expecting me to post the benchmark, and I frankly only looked
at the real time and forgot there was a systime in there that needed
cutting out when I posted it. My error, not his. I must say though, the
real time makes me quite happy, especially considering how CPUs are just
going to keep getting faster.

Best,

Hans
