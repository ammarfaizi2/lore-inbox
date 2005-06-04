Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFDKIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFDKIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 06:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFDKIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 06:08:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:33768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261211AbVFDKIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 06:08:23 -0400
Date: Sat, 4 Jun 2005 03:07:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank Elsner <frank@moltke28.B.Shuttle.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11:   kernel BUG at fs/jbd/checkpoint.c:247!
Message-Id: <20050604030740.3527d0d2.akpm@osdl.org>
In-Reply-To: <E1DeUkr-000555-PI@moltke28.B.Shuttle.DE>
References: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
	<20050603163356.5e7fc472.akpm@osdl.org>
	<E1DeUkr-000555-PI@moltke28.B.Shuttle.DE>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Elsner <frank@moltke28.B.Shuttle.DE> wrote:
>
>  Shall I go to linux-2.6.12-rcX or stay with linux-2.6.11.11?

2.6.12-rcx, please.  The 2.6.11 stream is a maintenance branch based upon
the now-very-old 2.6.11.  There has been no attempt (yet) to fix this bug
in the 2.6.11 stream.


