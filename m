Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWI3Txt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWI3Txt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWI3Txs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:53:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751798AbWI3Txr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:53:47 -0400
Date: Sat, 30 Sep 2006 12:53:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tobias Diedrich <ranma@tdiedrich.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-Id: <20060930125342.036aab26.akpm@osdl.org>
In-Reply-To: <20060930133706.GA3291@melchior.yamamaya.is-a-geek.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<20060930133706.GA3291@melchior.yamamaya.is-a-geek.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 15:37:06 +0200
Tobias Diedrich <ranma@tdiedrich.de> wrote:

> Andrew Morton wrote:
> 
> > - More updates to the MSI code.  If your machine has Message Signalled
> >   Interrupts, please enable it and give it a try.
> 
> I'm happy to report, that with 2.6.18-mm2 suspend to disk works for
> me without additional patches, tested both with MSI interrupts
> disabled and enabled (forcedeth driver).

Thanks.

Which kernel version(s) didn't work?  -mm1?  Mainline?
