Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032124AbWLGMXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032124AbWLGMXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032126AbWLGMXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:23:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43649 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032124AbWLGMXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:23:39 -0500
Date: Thu, 7 Dec 2006 12:30:11 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] x86_64: do not enable the NMI watchdog by default
Message-ID: <20061207123011.4b723788@localhost.localdomain>
In-Reply-To: <20061207121135.GA15529@elte.hu>
References: <20061206223025.GA17227@elte.hu>
	<200612061857.30248.len.brown@intel.com>
	<20061207121135.GA15529@elte.hu>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 13:11:35 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> or via the nmi_watchdog=1 or nmi_watchdog=2 boot options.
> 
> build and boot tested on an Athlon64 box.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Alan Cox <alan@redhat.com>

