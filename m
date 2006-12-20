Return-Path: <linux-kernel-owner+w=401wt.eu-S964965AbWLTLx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWLTLx7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWLTLx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:53:59 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:53605 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964965AbWLTLx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:53:58 -0500
Date: Wed, 20 Dec 2006 13:53:55 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix boot time hang in detect_calgary()
Message-ID: <20061220115355.GC30145@rhun.ibm.com>
References: <20061220105332.GA20922@elte.hu> <20061220113415.GB30145@rhun.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220113415.GB30145@rhun.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 01:34:15PM +0200, Muli Ben-Yehuda wrote:
> On Wed, Dec 20, 2006 at 11:53:32AM +0100, Ingo Molnar wrote:

[snipped patch]

> Patch looks good to me, thanks. I'll give it a spin to verify.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

Andi, I assume you'll push it to mainline?

This should go into -stable too.

Cheers,
Muli
