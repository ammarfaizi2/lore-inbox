Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWKXTxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWKXTxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933049AbWKXTxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 14:53:51 -0500
Received: from [198.99.130.12] ([198.99.130.12]:40920 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S933046AbWKXTxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 14:53:50 -0500
Date: Fri, 24 Nov 2006 14:50:11 -0500
From: Jeff Dike <jdike@addtoit.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
Subject: Re: + uml-make-execvp-safe-for-our-usage.patch added to -mm tree
Message-ID: <20061124195011.GB4745@ccure.user-mode-linux.org>
References: <200610180014.k9I0EZ1J012332@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610180014.k9I0EZ1J012332@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 05:14:35PM -0700, akpm@osdl.org wrote:
> The patch titled
> 
>      uml: make execvp safe for our usage
> 
> has been added to the -mm tree.  Its filename is
> 
>      uml-make-execvp-safe-for-our-usage.patch
> 

I had previously objected to this patch on grounds of taste.  Since
this fixes a number of problems, and I don't have any solutions which
are huge improvements, I withdraw those objections.

Feel free to send to Linus.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
