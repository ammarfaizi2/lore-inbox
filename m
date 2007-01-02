Return-Path: <linux-kernel-owner+w=401wt.eu-S1753724AbXABUrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbXABUrS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbXABUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:47:18 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:60200 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbXABUrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:47:17 -0500
Message-ID: <459AC472.4070303@gmail.com>
Date: Tue, 02 Jan 2007 21:45:38 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Robert Hancock <hancockr@shaw.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@osdl.org,
       Jean Delvare <khali@linux-fr.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net, Mark Lord <lkml@rtr.ca>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Christoph Hellwig <hch@lst.de>, petero2@telia.com
Subject: Re: 2.6.20-rc3: known regressions with patches available (part 1)
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070102192449.GV20714@stusta.de> <20070102192651.GM2483@kernel.dk> <20070102193429.GX20714@stusta.de>
In-Reply-To: <20070102193429.GX20714@stusta.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> On Tue, Jan 02, 2007 at 08:26:52PM +0100, Jens Axboe wrote:

>> Patch is already merged in -git.
> 
> Thanks for this information, I missed this (as well as the merged SATA 
> fix) since it isn't yet at the git mirrors.

What's "-git" here? I just now pulled

git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

and it's not there.

Otherwise, patch confirmed to work by me as well.

Cheers,
Rene

