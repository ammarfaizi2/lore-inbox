Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbUKTA1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbUKTA1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUKTAZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:25:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:26540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262502AbUKTAWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:22:40 -0500
Date: Fri, 19 Nov 2004 16:26:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: tridge@samba.org
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
Message-Id: <20041119162651.2d62a6a8.akpm@osdl.org>
In-Reply-To: <16798.31565.306237.930372@samba.org>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
>
> Would anyone care to hazard a guess as to what aspect of -mm2 is
> gaining us 10% in overall Samba4 performance?

Is it reproducible with your tricked-up dbench?

If so, please send me a machine description and the relevant command line
and I'll do a bsearch.

