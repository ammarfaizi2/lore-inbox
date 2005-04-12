Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVDLVSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVDLVSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVDLVKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:10:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:43727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262987AbVDLVIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:08:18 -0400
Date: Tue, 12 Apr 2005 14:08:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: incoming
Message-Id: <20050412140800.43d45d01.akpm@osdl.org>
In-Reply-To: <20050412215526.B11984@flint.arm.linux.org.uk>
References: <20050412032322.72d73771.akpm@osdl.org>
	<20050412215526.B11984@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> I don't see a patch which adds linux/pm.h to linux/sysdev.h, which is
>  required to fix ARM builds in -rc2 and onwards kernels.

That fix is buried in [patch 105/198]
