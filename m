Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUKTEE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUKTEE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUKTD6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:58:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:10216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263099AbUKTD5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:57:30 -0500
Date: Fri, 19 Nov 2004 19:57:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Morten W. Petersen" <morten@nidelven-it.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing page allocation failure
Message-Id: <20041119195718.5424bb88.akpm@osdl.org>
In-Reply-To: <419E997E.6000404@nidelven-it.no>
References: <419C8756.3080709@nidelven-it.no>
	<20041118180124.0e6bf05e.akpm@osdl.org>
	<419E997E.6000404@nidelven-it.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Morten W. Petersen" <morten@nidelven-it.no> wrote:
>
> Andrew Morton wrote:
>  > It should also emit a stack backtrace.   If so, please send it.
> 
>  OK, I've attached the kern.log file

That's just a bunch of hex numbers.  Please enable CONFIG_KALLSYMS and
resend.

