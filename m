Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVKQVD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVKQVD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVKQVD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:03:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964864AbVKQVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:03:57 -0500
Date: Thu, 17 Nov 2005 13:04:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: trond.myklebust@fys.uio.no, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051117130403.4155c94c.akpm@osdl.org>
In-Reply-To: <20051117160107.41041.qmail@web34101.mail.mud.yahoo.com>
References: <1132182378.8811.93.camel@lade.trondhjem.org>
	<20051117160107.41041.qmail@web34101.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson <theonetruekenny@yahoo.com> wrote:
>
> The pwrite never returns.
> So it seems to be a problem NOT with an absolute 4GB, but with a total of 4GB having been written.

Could you send the test app please?  (Apologies if you've already done so
and I missed it).

