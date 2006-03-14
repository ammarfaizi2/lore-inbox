Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWCNApb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWCNApb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWCNApa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:45:30 -0500
Received: from ozlabs.org ([203.10.76.45]:49867 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751761AbWCNAp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:45:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17430.4639.109055.803249@cargo.ozlabs.ibm.com>
Date: Tue, 14 Mar 2006 11:45:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
       ben@fluff.org
Subject: Re: [PATCH] define setup_arch() in header file
In-Reply-To: <20060305230321.6ce3ea57.akpm@osdl.org>
References: <20060305204418.GA7244@home.fluff.org>
	<20060305230321.6ce3ea57.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> There are already declarations of setup_arch in include/asm-ppc and
> include/asm-powerpc.  Different declarations.

There are?  Grep doesn't show them to me.

Paul.
