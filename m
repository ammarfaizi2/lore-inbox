Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVANBdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVANBdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVANBaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:30:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:63701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261720AbVANB1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:27:11 -0500
Date: Thu, 13 Jan 2005 17:26:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lcall disappeared? kernel CVS destabilized?
Message-Id: <20050113172651.70b4fcd5.akpm@osdl.org>
In-Reply-To: <20050114010132.GJ5949@dualathlon.random>
References: <20050114010132.GJ5949@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@cpushare.com> wrote:
>
> I'm porting the seccomp patch to 2.6.10, do you have an idea where lcall
>  (i.e. call gates for binary compatibility with other OS) went? 

Was removed on October 18.

http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/entry.S@1.83?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|hist/arch/i386/kernel/entry.S
