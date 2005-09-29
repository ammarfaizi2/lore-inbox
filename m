Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVI2T3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVI2T3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVI2T3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:29:38 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:50067 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932215AbVI2T3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:29:38 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04a/04] pci_ids: whitespace cleanup, resend first half
Date: Fri, 30 Sep 2005 05:29:20 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <33eoj1tpebaaibjo7a3mg0en2f5jlofadq@4ax.com>
References: <vo0nj19p336vsm05mrtefan1fajgi6qngi@4ax.com> <20050929161450.GC19770@kroah.com>
In-Reply-To: <20050929161450.GC19770@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005 09:14:51 -0700, Greg KH <greg@kroah.com> wrote:

>On Thu, Sep 29, 2005 at 04:02:26PM +1000, Grant Coady wrote:
>> 
>> From: Grant Coady <gcoady@gmail.com>
>> 
>> pci_ids.h: whitespace cleanup, split into two 'cos lkml ate single patch.
>
>This patch is going to be tough, as it will conflict with everything at
>the same time (other trees that touch the file.)
>
>I'll do this by hand, right before sending Linus a PCI git tree to
>merge, if you don't mind.

Would you like the patchset broken to smaller hunks so you can drop 
conflicting hunks and I'll resubmit the dropped hunks later?  

Since I learned to break a 115k hunk, can break it up some more ;-)

Choose a number?

>> + *
>> + *	September 2005 - cleanup by Grant Coady <gcoady@gmail.com>
>
>changelog stuff within files is not needed, or encouraged at all.
>That's why we have changelogs now.

So people can blame me for many hundred missing symbols?

Thanks,
Grant.

