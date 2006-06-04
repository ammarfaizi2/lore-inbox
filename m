Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751248AbWFDMtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWFDMtP (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 08:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWFDMtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 08:49:15 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:54277 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1751248AbWFDMtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 08:49:15 -0400
Subject: Dreamcast AICA sound support added to linux-sh cvs
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: linux-sh <linuxsh-dev@lists.sourceforge.net>,
        Paul Mundt <lethal@linux-sh.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Alsa-devel <alsa-devel@lists.sourceforge.net>,
        Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 13:49:05 +0100
Message-Id: <1149425346.9084.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-sh cvs mailing list still appears to be down, so this is to
notify you all that I have added the Dreamcast sound support to the
linux-sh cvs.

Unfortunately I cannot post the patch directly to lkml as it contains
some text the majordomo automatically rejects. but those who want to see
the code can look here:
http://linuxsh.cvs.sourceforge.net/linuxsh/linux/

I appreciate this really needs to get added to mainline via ALSA but I
wanted to store it all somewhere safer than my home network and I have
developer access to linux-sh, so that was the obvious place.

However, please note that it requires a patch to the linux-sh dma to
work. Paul has said he will add the patch but if he has it isn't yet
visible in the anon cvs. So the cvs code may not work at the moment.

