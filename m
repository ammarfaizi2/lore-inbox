Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTFHDjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 23:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTFHDjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 23:39:51 -0400
Received: from codepoet.org ([166.70.99.138]:61135 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264454AbTFHDju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 23:39:50 -0400
Date: Sat, 7 Jun 2003 21:53:14 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030608035314.GA10781@dillweed.codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.21-rc7-erik, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jun 07 2003 - 21:41:23 EST, Andrew Miklas wrote:
> Awhile ago, I mentioned that the Linksys WRT54G wireless access
> point used several GPL projects in its firmware, but did not
> seem to have any of the source available, or acknowledge the
> use of the GPLed software.  Four weeks 
[--------snip-----------]

> Incidentally, there is at least one other GPLed project in the
> firmware:
>   the BusyBox userland component: (http://www.busybox.net/) 

<BusyBox maintainer hat on>

I went through a similar exercise several weeks ago when I saw
the thread on the l-k mailing list.  It took just a fix minutes
to extract the linux kernel and cramfs filesystem from their
firmware.  Linksys is indeed shipping BusyBox and the Linux
kernel without releasing source in violation of the GPL.  I had
my lawyer (it helps to have a lawyer for a Dad) send them a
rather polite but firm letter about 3 weeks ago.  No response.
So he has now sent them a second letter...  Assuming we again get
no response, Linksys is going to find themselves in court in the
very near future.

I like Linksys and I have several of their products.  Nobody
forced them to use Linux.  Nobody forced them to use BusyBox.
But when they made the choice to use them, they committed
themselves to abiding by the law.  And the law says then when
companies violate software licenses and don't take care of the
problem when asked politely, they have to pay my Dad lots of
money for the legal time it takes him to sue their pants off...
:-)

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
