Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUFPE0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUFPE0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUFPE0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:26:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:36540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266156AbUFPE0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:26:07 -0400
Date: Tue, 15 Jun 2004 21:25:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: foo@porto.bmb.uga.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-Id: <20040615212516.521bbb3f.akpm@osdl.org>
In-Reply-To: <20040616041313.GC13868@porto.bmb.uga.edu>
References: <20040615062236.GA12818@porto.bmb.uga.edu>
	<20040615030932.3ff1be80.akpm@osdl.org>
	<20040615150036.GB12818@porto.bmb.uga.edu>
	<20040615162607.5805a97e.akpm@osdl.org>
	<20040616024842.GC13672@porto.bmb.uga.edu>
	<20040615195822.7e7151aa.akpm@osdl.org>
	<20040616041313.GC13868@porto.bmb.uga.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

foo@porto.bmb.uga.edu wrote:
>
>  > Lovely.  Please send over the kernel boot command line.
> 
>  Here's the dmesg, extracted from the logs.

So what do we conclude from this?  It booted OK, but the serial console
broke, and perhaps the serial driver broke, and perhaps the tg3 driver
broke?
