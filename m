Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934173AbWKTOO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934173AbWKTOO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934174AbWKTOO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:14:57 -0500
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:25013 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S934173AbWKTOO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:14:57 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061118163032.GA14625@elte.hu>
References: <20061118163032.GA14625@elte.hu>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Nov 2006 14:14:53 +0000
Message-Id: <1164032093.10606.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-18 at 17:30 +0100, Ingo Molnar wrote:
> i've released the 2.6.18-rc6-rt4 tree, which can be downloaded from the 
> usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> NOTE: the YUM repository has changed the -rt kernel's package name, it's 
> now kernel-rt, so it does not override the kernel package. If you have 
> rt.repo already then just do a "yum install kernel-rt".
> 
> If there's no rt repository yet, the -rt YUM repository for Fedora Core 
> 6 can be activated via:

Can you provide kernel-rt-devel for compile nvidia DRI kernel module ? 

I had tried 2.6.19-rc6-rt4, and no regressions from 2.6.18+dyntick.

but I still can freeze computer when make heavy copy to SATA HD. 
Thanks,

Sérgio M. B. 

