Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWJPOzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWJPOzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWJPOzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:55:10 -0400
Received: from [198.99.130.12] ([198.99.130.12]:22749 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932106AbWJPOzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:55:09 -0400
Date: Mon, 16 Oct 2006 10:53:37 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] make UML copmile
Message-ID: <20061016145337.GD4350@ccure.user-mode-linux.org>
References: <200610151903.k9FJ3mHG016757@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610151903.k9FJ3mHG016757@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 03:03:48PM -0400, Ulrich Drepper wrote:
> I need this patch to get a UML kernel to compile.  This is with the kernel
> headers in FC6 which are automatically generated from the kernel tree.
> Some headers are missing but those files don't need them.  At least it
> appears so since the resuling kernel works fine.
> 
> Tested on x86-64.

Acked-by: Jeff Dike <jdike@addtoit.com>

Thanks, Ulrich.

				Jeff
