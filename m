Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317804AbSGKJwN>; Thu, 11 Jul 2002 05:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGKJwM>; Thu, 11 Jul 2002 05:52:12 -0400
Received: from users-vst.linvision.com ([62.58.92.114]:2948 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317804AbSGKJwK>; Thu, 11 Jul 2002 05:52:10 -0400
Message-Id: <200207110954.LAA08806@cave.bitwizard.nl>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
In-Reply-To: <20020709200711.GA13401@win.tue.nl> from Andries Brouwer at "Jul
 9, 2002 10:07:11 pm"
To: Andries Brouwer <aebr@win.tue.nl>
Date: Thu, 11 Jul 2002 11:54:03 +0200 (MEST)
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Tue, Jul 09, 2002 at 12:22:49PM +0200, Jens Axboe wrote:
> 
> > I've forward ported the 2.4 IDE core to 2.5.25.
> 
> Very good!

Ehmm. We have had "old IDE support" in the kernel for "ages".  We have
two aic7xxx driver, two rtl8139 drivers, two, or more ncr53c8xx drivers. 

So why in the case of IDE has the "new IDE" driver not been forked and
implemented under a new "name" such that those working on other stuff
can chose to use the "old reliable" driver while others daring to test
the new advanced rewrite can do so?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
