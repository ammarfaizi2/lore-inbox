Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTFIDdR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 23:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTFIDdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 23:33:17 -0400
Received: from mailout.fastq.com ([204.62.193.66]:40720 "EHLO
	mailout.fastq.com") by vger.kernel.org with ESMTP id S263952AbTFIDdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 23:33:16 -0400
Subject: Re: Linksys WRT54G and the GPL
From: Russ Dill <Russ.Dill@asu.edu>
Reply-To: Russ.Dill@asu.edu
To: linux-kernel@vger.kernel.org
Cc: andersen@codepoet.org
Message-Id: <1055130436.1042.7.camel@russ.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 08 Jun 2003 20:47:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<udhcp maintainer hat on>

> <BusyBox maintainer hat on>

> I went through a similar exercise several weeks ago when I saw
> the thread on the l-k mailing list.  It took just a fix minutes
> to extract the linux kernel and cramfs filesystem from their
> firmware.  Linksys is indeed shipping BusyBox and the Linux
> kernel without releasing source in violation of the GPL.  I had
> my lawyer (it helps to have a lawyer for a Dad) send them a
> rather polite but firm letter about 3 weeks ago.  No response.
> So he has now sent them a second letter...  Assuming we again get
> no response, Linksys is going to find themselves in court in the
> very near future.

<udhcp maintainer hat on>

While a company including udhcp is a really exciting thing for me, its
mostly exciting because I get the additional resources of anyone at
linksys working on the code, and they get a low cost of ownership dhcp
server. Of course, if they don't send me the code, it doesn't help me at
all, and I get pissed off.

By downloading the firmware, and looking at the output of strings
usr/sbin/udhcpd makes it pretty clear that they have made modifications.
Anyway, sign me on for whatever legal actions you are making, caus I
want my code back.

-- 
Russ Dill

