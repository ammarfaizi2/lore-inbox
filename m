Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTJWLIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 07:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTJWLIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 07:08:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:29920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263529AbTJWLIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 07:08:45 -0400
Date: Thu, 23 Oct 2003 04:08:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "vwake" <vwake@indiatimes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High Utilization kswapd and kupdated in Large memory system
Message-Id: <20031023040856.07b9822a.akpm@osdl.org>
In-Reply-To: <200310231005.PAA20811@WS0005.indiatimes.com>
References: <200310231005.PAA20811@WS0005.indiatimes.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"vwake" <vwake@indiatimes.com> wrote:
>
> On large memory machine ( 32 GB RAM) 
> ...
> The kernel is version 2.4.22

Not a chance, my friend.

Try 2.4.23-pre8, or 2.6.


