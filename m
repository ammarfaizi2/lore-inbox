Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUKSCFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUKSCFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUKSCDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:03:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:10459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbUKSCBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 21:01:38 -0500
Date: Thu, 18 Nov 2004 18:01:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Morten W. Petersen" <morten@nidelven-it.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing page allocation failure
Message-Id: <20041118180124.0e6bf05e.akpm@osdl.org>
In-Reply-To: <419C8756.3080709@nidelven-it.no>
References: <419C8756.3080709@nidelven-it.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Morten W. Petersen" <morten@nidelven-it.no> wrote:
>
> I have a server that a couple of times each day squirts out messages 
>  about page allocation failures (python: page allocation failure. 
>  order:3, mode:0x20).

It should also emit a stack backtrace.   If so, please send it.
