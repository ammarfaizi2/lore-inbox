Return-Path: <linux-kernel-owner+w=401wt.eu-S964924AbXABT07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbXABT07 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbXABT06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:26:58 -0500
Received: from brick.kernel.dk ([62.242.22.158]:21028 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964921AbXABT05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:26:57 -0500
Date: Tue, 2 Jan 2007 20:26:52 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Robert Hancock <hancockr@shaw.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@osdl.org,
       Jean Delvare <khali@linux-fr.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net, Rene Herman <rene.herman@gmail.com>,
       Mark Lord <lkml@rtr.ca>, Laurent Riffard <laurent.riffard@free.fr>,
       Christoph Hellwig <hch@lst.de>, petero2@telia.com
Subject: Re: 2.6.20-rc3: known regressions with patches available (part 1)
Message-ID: <20070102192651.GM2483@kernel.dk>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070102192449.GV20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102192449.GV20714@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2007, Adrian Bunk wrote:
> Subject    : CFQ disk throughput halved
> References : http://lkml.org/lkml/2007/01/1/104
> Submitter  : Rene Herman <rene.herman@gmail.com>
>              Mark Lord <lkml@rtr.ca>
> Caused-By  : Jens Axboe <jens.axboe@oracle.com>
>              commit 719d34027e1a186e46a3952e8a24bf91ecc33837
> Handled-By : Jens Axboe <jens.axboe@oracle.com>
> Patch      : http://lkml.org/lkml/2007/1/2/75
> Status     : patch available

Patch is already merged in -git.

-- 
Jens Axboe

