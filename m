Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWCNQYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWCNQYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWCNQYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:24:34 -0500
Received: from B.painless.aaisp.net.uk ([81.187.81.52]:53389 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1751768AbWCNQY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:24:26 -0500
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
From: Andrew Clayton <andrew@rootshell.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603140805380.3618@g5.osdl.org>
References: <1142337319.4412.2.camel@zeus.pccl.info>
	 <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
	 <Pine.LNX.4.64.0603140805380.3618@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 16:24:03 +0000
Message-Id: <1142353443.30466.2.camel@zeus.pccl.info>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 08:06 -0800, Linus Torvalds wrote:
> 
> On Tue, 14 Mar 2006, Hugh Dickins wrote:
> >
> > Yep, that one's a turkey, definitely something for Linus to revert.
> 
> Reverted. Let's get wider testing before applying an alternate fix.
> 
> 		Linus


Just to note: Doing what Andi suggested seems to be working OK.

Cheers,

Andrew


