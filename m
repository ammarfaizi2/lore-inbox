Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWJWRN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWJWRN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWJWRN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:13:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964963AbWJWRN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:13:58 -0400
Date: Mon, 23 Oct 2006 10:13:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Claudio Martins <ctpm@ist.utl.pt>
cc: David Miller <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unintended commit?
In-Reply-To: <200610231809.09238.ctpm@ist.utl.pt>
Message-ID: <Pine.LNX.4.64.0610231013340.3962@g5.osdl.org>
References: <200610231809.09238.ctpm@ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Oct 2006, Claudio Martins wrote:
> 
>  I noticed that commit 4e8a5201506423e0241202de1349422af4260296 on Linus' tree 
> titled "[PKT_SCHED] netem: Orphan SKB when adding to queue." also touches the 
> file "drivers/pci/quirks.c", which seems unrelated.

Indeed. Thanks for noticing.

David, can you pls explain?

		Linus
