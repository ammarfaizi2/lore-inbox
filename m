Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVBYHiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVBYHiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVBYHiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:38:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:7077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262641AbVBYHix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:38:53 -0500
Date: Thu, 24 Feb 2005 23:38:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 05/12] acpi: sleep-while-atomic during S3 resume from
 ram
Message-Id: <20050224233815.3c9a4908.akpm@osdl.org>
In-Reply-To: <200502250832.46209.linux-kernel@borntraeger.net>
References: <200502230953.j1N9rFj1020702@shell0.pdx.osdl.net>
	<200502250832.46209.linux-kernel@borntraeger.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger <linux-kernel@borntraeger.net> wrote:
>
> akpm@osdl.org wrote:
> > From: Christian Borntraeger <linux-kernel@borntraeger.net>
> >
> > During the wakeup from suspend-to-ram I get several warnings.
> >
> > Signed-off-by: Christian Borntraeger <linux-kernel@borntraeger.net>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Andrew,
> 
> Len told me that he is going to solve the issue in a different and better 
> way.

OK, well I'll retain the patch until the problem is fixed anyway - it's my
lame-o bug tracking system.

