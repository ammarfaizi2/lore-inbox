Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRDPQRP>; Mon, 16 Apr 2001 12:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRDPQRG>; Mon, 16 Apr 2001 12:17:06 -0400
Received: from [216.174.202.135] ([216.174.202.135]:34566 "EHLO
	celeborn.rivendell.insynq.com") by vger.kernel.org with ESMTP
	id <S131289AbRDPQQv>; Mon, 16 Apr 2001 12:16:51 -0400
From: Ian Eure <ieure@insynq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15067.6955.346718.263498@pyramid.insynq.com>
Date: Mon, 16 Apr 2001 09:17:47 -0700
To: Jens Axboe <axboe@suse.de>
Cc: Ian Eure <ieure@insynq.com>, linux-kernel@vger.kernel.org
Subject: Re: loop problems continue in 2.4.3
In-Reply-To: <20010413145614.E13621@suse.de>
In-Reply-To: <15055.36597.353681.125824@pyramid.insynq.com>
	<20010409095607.A432@suse.de>
	<15060.43709.340915.563107@pyramid.insynq.com>
	<20010413145614.E13621@suse.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-Face: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > On Wed, Apr 11 2001, Ian Eure wrote:
 > > i get this message when it panics:
 > > 
 > > -- snip --
 > > loop: setting 534781920 bs for 07:86
 > > Kernel panic: Invalid blocksize passed to set_blocksize
 > > -- snip --
 > 
 > Ahm, how are you setting your loop device up? The above is completely
 > bogus.
 > 
`mount foo /mnt2 -oloop,dev'

-- 
 ___________________________________
| Ian Eure - <ieure@insynq.com>     | "You're living in a facist world...
|         -  Developer -            | Freedom is a luxury." -Front Line
|        -  InsynQ, Inc. -          | Assembly, "Digital Tension Dementia"
| Your Internet Utility Company.tm  |________________________________________
