Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTI2RL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTI2RJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:09:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:36743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263815AbTI2RJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:09:11 -0400
Subject: Re: 2.6.0-test6-mm1
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030928191038.394b98b4.akpm@osdl.org>
References: <20030928191038.394b98b4.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064855347.23108.5.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Sep 2003 10:09:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-28 at 19:10, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1
> 
> 
> Lots of small things mainly.
> 
> The O_DIRECT-vs-buffers I/O locking changes appear to be complete, so testing
> attention on O_DIRECT workloads would be useful.
> 

OSDL's STP automatically ran dbt2 tests against 2.6.0-test6-mm1 this
morning (PLM patch #2174).

The dbt2 test uses raw devices and all the runs completed successfully.

Daniel


