Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVJWTGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVJWTGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 15:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVJWTGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 15:06:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750896AbVJWTGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 15:06:39 -0400
Date: Sun, 23 Oct 2005 12:05:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, arjan@infradead.org,
       pavel@ucw.cz, dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ib.com,
       mingo@elte.hu, manfred@colorfullife.com, gregkh@kroah.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Message-Id: <20051023120521.26031051.akpm@osdl.org>
In-Reply-To: <200510232055.17782.ioe-lkml@rameria.de>
References: <20051022231214.GA5847@us.ibm.com>
	<200510230922.26550.ioe-lkml@rameria.de>
	<20051023143617.GA7961@us.ibm.com>
	<200510232055.17782.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
> DEBUG_KERNEL should do nothing more than showing the debugging
>  options. 

yup.

>  E.g. I don't expect to enable any additional code in an 
>  unrelated file, if I enable Magic-SysRQ on an embedded, unattended device
>  to be able to analyze potential problems via serial console.
> 
>  @Andrew: Would you accept a patch to fix that?

more yup.
