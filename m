Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbUKEOmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUKEOmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUKEOmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:42:47 -0500
Received: from host18.201-252-6.telecom.net.ar ([201.252.6.18]:54180 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S261629AbUKEOmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:42:45 -0500
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Date: Fri, 5 Nov 2004 11:42:43 -0300
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, Amit Shah <amitshah@gmx.net>
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu>
In-Reply-To: <20041105134639.GA14830@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411051142.43394.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Amit Shah <amitshah@gmx.net> wrote:
> > I'm trying out the RT preempt patch on a P4 HT machine, I get the
> > following message:
> >
> hm, does this happen with -V0.7.13 too? (note that it's against
> 2.6.10-rc1-mm3, a newer -mm tree.)

But it doesn't -cleanly- apply. 

Hunk #2 FAILED at 1545.
1 out of 2 hunks FAILED -- saving rejects to file mm/mmap.c.rej

Regards,
Norberto
