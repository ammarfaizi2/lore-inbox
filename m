Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWBNSff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWBNSff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWBNSff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:35:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:7889 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030350AbWBNSfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:35:34 -0500
Subject: Re: [PATCH] jfs: use kthread_ API
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060214175545.GA19225@lst.de>
References: <20060214175545.GA19225@lst.de>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 12:35:27 -0600
Message-Id: <1139942127.9990.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 18:55 +0100, Christoph Hellwig wrote:
> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This looks good.  I'll take a closer look and probably push it to -mm as
soon as I can get to it.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

