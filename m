Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVJOBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVJOBVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJOBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 21:21:21 -0400
Received: from xenotime.net ([66.160.160.81]:49036 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751012AbVJOBVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 21:21:20 -0400
Date: Fri, 14 Oct 2005 18:21:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops
Message-Id: <20051014182118.30c7d947.rdunlap@xenotime.net>
In-Reply-To: <4350554F.7010503@perkel.com>
References: <4350554F.7010503@perkel.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005 18:03:11 -0700 Marc Perkel wrote:

> What is this? Kernel 2.6.13.2 64 bit Dual Core Athlox X2
> 
> Message from syslogd@pascal at Fri Oct 14 16:44:47 2005 ...
> pascal kernel: Oops: 0000 [1] SMP
> 
> Message from syslogd@pascal at Fri Oct 14 16:44:57 2005 ...
> pascal kernel: CR2: 0000000000000800

It appears to be a Kernel Oops ($subject), but there's not
enough of it listed here to determine what happened.

See http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
or better:  linux/REPORTING-BUGS
and linux/Documentation/oops-tracing.txt

---
~Randy
