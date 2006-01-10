Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWAJCm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWAJCm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWAJCm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:42:27 -0500
Received: from mail.dvmed.net ([216.237.124.58]:4036 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932289AbWAJCm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:42:26 -0500
Message-ID: <43C31F08.304@pobox.com>
Date: Mon, 09 Jan 2006 21:42:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@elte.hu, rostedt@goodmis.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mutex subsystem, semaphore to completion: SX8
References: <200601100207.k0A27B4J007573@hera.kernel.org>
In-Reply-To: <200601100207.k0A27B4J007573@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linux Kernel Mailing List wrote: > tree
	c45749fcb6f8f22d9e2666135b528c885856aaed > parent
	7892f2f48d165a34b0b8130c8a195dfd807b8cb6 > author Steven Rostedt
	<rostedt@goodmis.org> Tue, 10 Jan 2006 07:59:26 -0800 > committer Ingo
	Molnar <mingo@hera.kernel.org> Tue, 10 Jan 2006 07:59:26 -0800 > >
	[PATCH] mutex subsystem, semaphore to completion: SX8 > > change SX8
	semaphores to completions. > > Signed-off-by: Ingo Molnar
	<mingo@elte.hu> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> tree c45749fcb6f8f22d9e2666135b528c885856aaed
> parent 7892f2f48d165a34b0b8130c8a195dfd807b8cb6
> author Steven Rostedt <rostedt@goodmis.org> Tue, 10 Jan 2006 07:59:26 -0800
> committer Ingo Molnar <mingo@hera.kernel.org> Tue, 10 Jan 2006 07:59:26 -0800
> 
> [PATCH] mutex subsystem, semaphore to completion: SX8
> 
> change SX8 semaphores to completions.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Please at least CC the maintainer (me) _sometime_ before pushing 
upstream, when you modify a driver...

	Jeff


