Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUJKTMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUJKTMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJKTMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:12:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:11233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269203AbUJKTJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:09:33 -0400
Date: Mon, 11 Oct 2004 12:13:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Message-Id: <20041011121331.58bd9c0a.akpm@osdl.org>
In-Reply-To: <416A70AA.3040608@yahoo.com.au>
References: <20041011032502.299dc88d.akpm@osdl.org>
	<416A70AA.3040608@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > +no-wild-kswapd-2.patch
> 
> Is this an improvement?

Seems to be a wash in my testing.

> It again decouples the "priority" semantics of
> the direct and asynch reclaim paths.

What's that mean?
