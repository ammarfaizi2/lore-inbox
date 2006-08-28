Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWH1IPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWH1IPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWH1IPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:15:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:52689 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751421AbWH1IPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:15:50 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:15:38 +0200
User-Agent: KMail/1.9.3
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, jdike@addtoit.com,
       B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, dwmw2@infradead.org
References: <200608280950.04441.ak@suse.de> <200608281003.02757.ak@suse.de> <20060828.010948.131918560.davem@davemloft.net>
In-Reply-To: <20060828.010948.131918560.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281015.38389.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 10:09, David Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Mon, 28 Aug 2006 10:03:02 +0200
> 
> > Thanks for brining it to my attention. I indeed think think the
> > patch was wrong.
> 
> I disagree, this stuff really doesn't have a strong argument
> for existence.

I see it as the reference implementation of the kernel system call ABI

-Andi
