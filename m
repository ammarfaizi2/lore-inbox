Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFKDLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFKDLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 23:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVFKDLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 23:11:18 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:36486 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261168AbVFKDLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 23:11:15 -0400
Date: Fri, 10 Jun 2005 20:11:07 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: lnxluv@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6: problem with module tainting the kernel
Message-Id: <20050610201107.60a8c3ae.rdunlap@xenotime.net>
In-Reply-To: <20050610153506.GA8118@infradead.org>
References: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
	<20050610153506.GA8118@infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005 16:35:06 +0100 Christoph Hellwig wrote:

| On Fri, Jun 10, 2005 at 08:24:50AM -0700, li nux wrote:
| > In 2.6 kernels how to assure that on inserting our own
| > module, it doesn't throw the warning:
| > 
| > "unsupported module, tainting kernel"
| 
| There's no place in the kernel that produces this message.  Are you
| using some odd vendor tree?

to put it another way, show us all of the kernel
messages from when you try to load the module.

---
~Randy
