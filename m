Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUCWPg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCWPg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 10:36:56 -0500
Received: from ns.suse.de ([195.135.220.2]:48101 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262652AbUCWPgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 10:36:52 -0500
Date: Tue, 23 Mar 2004 16:36:55 +0100
From: Andi Kleen <ak@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] let EDD work on x86-64 too
Message-Id: <20040323163655.50000c1c.ak@suse.de>
In-Reply-To: <20040323153142.GA20267@lists.us.dell.com>
References: <20040316162344.GA20289@lists.us.dell.com>
	<20040316165127.GB6145@wotan.suse.de>
	<20040323153142.GA20267@lists.us.dell.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 09:31:42 -0600
Matt Domsch <Matt_Domsch@dell.com> wrote:

> 
> The i386 changes have hit 2.6.5-rc2.  x86-64 patch below for your
> consideration.  I'm intentionally not copying the
> Documentation/i386/zero_page.txt file as it's the same as x86 in this
> regard.  This boots and works for me.

Thanks. Applied. 

Won't make 2.6.5 though.

-Andi
