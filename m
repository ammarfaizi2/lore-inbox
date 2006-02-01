Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWBACa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWBACa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWBACa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:30:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbWBACa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:30:58 -0500
Date: Tue, 31 Jan 2006 18:30:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060131183035.2a9dd56f.akpm@osdl.org>
In-Reply-To: <20060201104334.D697.Y-GOTO@jp.fujitsu.com>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060201104334.D697.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> 
> Hi Andrew-san.
> 
> > -x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id.patch
> > -x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id-fix.patch
> > 
> >  Dropped - am awaiting version 2.
> 
> Should I repost this patch which includes fixes as a ver.2 ?
> I already posted fix patches for them.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113841952421236&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113841952421512&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113841952428750&w=2

Yes, I threw up my hands in horror and dropped everything.

> But, if you lost my first patch by managing too many patches,
> I'll repost total patch as ver.2.
> 

Yes, please resend everything, as a logical sequence-numbered patch series
(not patch1, fix-to-patch1, patch2, fix-to-patch2, etc) with no reference
to the previous patches and with full changelogs and with Signed-off-by:s
and everything else.

