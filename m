Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271627AbTGRDDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 23:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271632AbTGRDDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 23:03:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:6070 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271627AbTGRDDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 23:03:53 -0400
Date: Thu, 17 Jul 2003 20:19:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: george anzinger <george@mvista.com>
Cc: bernie@develer.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org
Subject: Re: do_div64 generic
Message-Id: <20030717201905.6ab4a90f.akpm@osdl.org>
In-Reply-To: <3F172CDB.3000005@mvista.com>
References: <3F1360F4.2040602@mvista.com>
	<3F149747.3090107@mvista.com>
	<200307162033.34242.bernie@develer.com>
	<200307172310.48918.bernie@develer.com>
	<20030717141608.5f1b7710.akpm@osdl.org>
	<3F172CDB.3000005@mvista.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> > Ths one's OK by me.  Let's just fix the bug with minimum risk and churn.
> 
>  Uh, bug?  I was not aware that there was a bug.  As far as I know, 
>  nothing is broken.

wtf?  Then why are people running around brandishing big scary patches
at me?

