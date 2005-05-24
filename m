Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVEXKEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVEXKEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVEXJoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:44:10 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:32712 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262017AbVEXJV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:21:26 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092121.6CE37FA7B@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:21:21 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id DE1F8FB74

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:46 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261332AbVEXG12 (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:27:28 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVEXG12

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:27:28 -0400

Received: from mail.dvmed.net ([216.237.124.58]:6349 "EHLO mail.dvmed.net")

	by vger.kernel.org with ESMTP id S261259AbVEXG1M (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:27:12 -0400

Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])

	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))

	id 1DaSsf-0001On-LK; Tue, 24 May 2005 06:27:10 +0000

Message-ID: <4292C93B.9000009@pobox.com>

Date:	Tue, 24 May 2005 02:27:07 -0400

From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5

X-Accept-Language: en-us, en

MIME-Version: 1.0

To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x libata new PCI ids

References: <4292BA93.801@pobox.com> <Pine.LNX.4.58.0505232310590.2307@ppc970.osdl.org>

In-Reply-To: <Pine.LNX.4.58.0505232310590.2307@ppc970.osdl.org>

Content-Type: text/plain; charset=us-ascii; format=flowed

Content-Transfer-Encoding: 7bit

X-Spam-Score: 0.0 (/)

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Jeff Garzik wrote:
> 
>>Please pull the 'new-ids' branch from
>>
>>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>>This add new PCI ids to some SATA drivers.
> 
> 
> So here the trees are identical in between the two versions, so the later 
> commit is definitely not doing anything. What's up?

pass 'refs/heads/new-ids' as the second arg to git-pull-script.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

