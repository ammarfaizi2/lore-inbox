Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVBGW4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVBGW4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVBGWyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:54:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:38091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVBGWwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:52:46 -0500
Date: Mon, 7 Feb 2005 14:57:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: clameter@sgi.com, torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re:
 move-accounting-function-calls-out-of-critical-vm-code-paths.patch
Message-Id: <20050207145748.435a68ea.akpm@osdl.org>
In-Reply-To: <42077724.1060606@sgi.com>
References: <20050110184617.3ca8d414.akpm@osdl.org>
	<Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com>
	<20050203140904.7c67a144.akpm@osdl.org>
	<Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com>
	<20050203150551.4d88f210.akpm@osdl.org>
	<42077724.1060606@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@sgi.com> wrote:
>
> I have tested Christoph's patch before the leave. It did work for CSA
> and showed performance improvement on certain configuration.

OK, thanks.

> Should i propose to include the CSA module in
> the kernel then, Andrew? :)

Sure, if such an action is suitable for all the other parties who are
interested in enhanced system accounting.

What this ballgame needs is for someone to grab the bull by the horns and
run with it.  This thing obviously requires a lot more cliches!
