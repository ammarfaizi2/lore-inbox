Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWI1UjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWI1UjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWI1UjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:39:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59783 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750702AbWI1UjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:39:13 -0400
Message-ID: <451C32EE.9080109@pobox.com>
Date: Thu, 28 Sep 2006 16:39:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: linux-ide@vger.intel.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/2] libata: _GTF support
References: <20060928182211.076258000@localhost.localdomain> <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
In-Reply-To: <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied patches 1-2.  Thanks to everyone involved -- you, Randy, and 
Forrest (who probably won't see this message).

I applied this to the new 'acpi' branch of libata-dev.git, and merged it 
into the meta-branch 'ALL', so that it will be automatically picked up 
by akpm's -mm tree.

I want this to get some testing before it goes upstream.

	Jeff



