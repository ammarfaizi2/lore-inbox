Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWJLHGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWJLHGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWJLHGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:06:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422771AbWJLHGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:06:49 -0400
Date: Thu, 12 Oct 2006 00:06:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.6.19-rc1
Message-Id: <20061012000643.f875c96e.akpm@osdl.org>
In-Reply-To: <452D43B6.8020406@tuxrocks.com>
References: <452D43B6.8020406@tuxrocks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 14:19:18 -0500
Frank Sorenson <frank@tuxrocks.com> wrote:

> I'm getting kernel panics within a few minutes of boot with 2.6.19-rc1 
> (latest git) on x86_64.  Other than "make oldconfig", it's an identical 
> configuration to a working kernel on 2.6.18.
> 
> The panic scrolls off the screen, but I copied down what was on the screen:

Can you get netconsole going?  Documentation/networking/netconsole.txt.
It's pretty simple.
