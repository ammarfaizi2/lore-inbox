Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWDXCAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWDXCAI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 22:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWDXCAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 22:00:08 -0400
Received: from xenotime.net ([66.160.160.81]:10389 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751488AbWDXCAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 22:00:06 -0400
Date: Sun, 23 Apr 2006 19:02:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 1/8] Setup
Message-Id: <20060423190232.2fe43995.rdunlap@xenotime.net>
In-Reply-To: <4449939D.7@watson.ibm.com>
References: <444991EF.3080708@watson.ibm.com>
	<4449939D.7@watson.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006 22:23:25 -0400 Shailabh Nagar wrote:

> Index: linux-2.6.17-rc1/include/linux/delayacct.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17-rc1/include/linux/delayacct.h	2006-04-21 19:39:29.000000000 -0400
> @@ -0,0 +1,69 @@
> +/* delayacct.h - per-task delay accounting
> + */
> +
> +#ifndef _LINUX_TASKDELAYS_H
> +#define _LINUX_TASKDELAYS_H

Probably _LINUX_DELAYACCT_H.
Or if I add linux/taskdelays.h, what #include guard should I use?

---
~Randy
