Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUEWTBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUEWTBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEWTBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:01:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64477 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263366AbUEWTAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:00:54 -0400
Message-ID: <40B0F4D5.5000807@pobox.com>
Date: Sun, 23 May 2004 15:00:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085334933.8494.1448.camel@localhost.localdomain>
In-Reply-To: <1085334933.8494.1448.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> Use of BK has lost some of the "many-eyeballs" positives of the past.
> Today's BkCommits-Head list only allows an after-the-fact review.
> Frequently, the patch author and sometimes the maintainer are the
> only parties to the change.  A pre-commit list could allow comments by
> interested parties on patches that today are under reviewed.


Although you do have a point, this is not really true.

For my stuff and several other maintainers, the patches generally appear 
To: <maintainer> CC: <mailing list>.  I specificially ask submittors to 
always CC a mailing list.

It is true that the maintainers (subsystem maintainers like me, or 
overall maintainers like Andrew and Linus) sometimes check in patches 
without much review, but even there, I usually send things that would be 
remotely controversial to the linux-ide/netdev/linux-kernel lists.

	Jeff


