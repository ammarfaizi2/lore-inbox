Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFCXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFCXel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCXdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:33:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:20450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbVFCXdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:33:07 -0400
Date: Fri, 3 Jun 2005 16:33:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank Elsner <frank@moltke28.B.Shuttle.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11:   kernel BUG at fs/jbd/checkpoint.c:247!
Message-Id: <20050603163356.5e7fc472.akpm@osdl.org>
In-Reply-To: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
References: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Elsner <frank@moltke28.B.Shuttle.DE> wrote:
>
> Jun  3 04:04:54 seymour kernel: kernel BUG at fs/jbd/checkpoint.c:247!

We're hoping that this is fixed now.  How repeatable is it for you?

Please test

ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.12-rc5.tar.bz2
plus
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc5-git8.bz2

Thanks.
