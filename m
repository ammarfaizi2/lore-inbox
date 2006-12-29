Return-Path: <linux-kernel-owner+w=401wt.eu-S1754071AbWL2GSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbWL2GSo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbWL2GSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:18:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33866 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbWL2GSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:18:43 -0500
Date: Thu, 28 Dec 2006 22:18:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: at arch/i386/mm/highmem.c:50 kmap_atomic()
Message-Id: <20061228221836.3d99db0d.akpm@osdl.org>
In-Reply-To: <1167364720.14081.57.camel@imap.mvista.com>
References: <1167364720.14081.57.camel@imap.mvista.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 19:58:40 -0800
Daniel Walker <dwalker@mvista.com> wrote:

> Got several of the messages below on 2.6.20-rc2-mm1 .
> 
> 
> Dec 29 03:34:08 10 kernel: [  264.519401] BUG: at arch/i386/mm/highmem.c:50 kmap_atomic()

doh, I had a copy-n-paste error in the debug code, thanks.
