Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUHQSOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUHQSOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268376AbUHQSOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:14:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:63695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268372AbUHQSNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:13:51 -0400
Date: Tue, 17 Aug 2004 11:12:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates for 2.6.8
Message-Id: <20040817111214.53ba6bcb.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.53.0408171212260.712440@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0408161127580.663457@subway.americas.sgi.com>
	<20040817000232.36bc64ac.akpm@osdl.org>
	<Pine.SGI.4.53.0408170958550.711096@subway.americas.sgi.com>
	<Pine.SGI.4.53.0408171212260.712440@subway.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Jacobson <erikj@subway.americas.sgi.com> wrote:
>
> Attached is a new PAGG patch that includes the fix in
>  process-aggregates-macro-fix.patch above.  This patch should now be
>  in line with 2.6.8.1-mm1.

Thanks.  I dropped the PAGG patch out of -mm - I don't think we're gaining
additional information from retaining it in there now.
