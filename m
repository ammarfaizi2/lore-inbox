Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbULGWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbULGWmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbULGWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:41:27 -0500
Received: from smtp2.eldosales.com ([63.78.12.18]:61195 "EHLO
	tweeter.eldosales.com") by vger.kernel.org with ESMTP
	id S261956AbULGWlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:41:16 -0500
Posted-Date: Tue, 7 Dec 2004 15:41:09 -0700
Subject: Re: qla2xxx fail over bug?
From: comsatcat <comsatcat@earthlink.net>
Reply-To: comsatcat@earthlink.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041207090342.GB13591@infradead.org>
References: <1102399799.12866.3.camel@solaris.skunkware.org>
	 <20041207090342.GB13591@infradead.org>
Content-Type: text/plain
Date: Tue, 07 Dec 2004 15:41:12 -0700
Message-Id: <1102459272.9757.1.camel@solaris.skunkware.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's not such printk in the kernel qla2xxx driver, so the bugs is
> in front of the computer as you patched in a bogus vendor driver.
> 

I apologize, the version of the qla2xxx driver was obtained from
qlogic's ftp site.  I assumed it was the beta versions being developed
at the qla2xxx sourceforge site as their ftp was referenced for updated
version (which I understand is the ones that get worked into the
kernel?).  I will contact qlogic directly.


Thanks,
Ben

