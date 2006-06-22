Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWFVVVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWFVVVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWFVVVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:21:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030403AbWFVVVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:21:13 -0400
Date: Thu, 22 Jun 2006 14:24:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] x86-64 build fix
Message-Id: <20060622142430.3219f352.akpm@osdl.org>
In-Reply-To: <20060622205928.GA23801@havoc.gtf.org>
References: <20060622205928.GA23801@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
>
> As of last night, I still needed the Kconfig patch below to
> successfully build allmodconfig on x86-64.  I believe Andrew has the
> patch with a proper description and attribution, so I would prefer
> that he send it...

It was transferred from the -mm-only stuff and into the x86_64 tree, so
Andi owns it now.

I'll steal it back and will send it to Linus.


