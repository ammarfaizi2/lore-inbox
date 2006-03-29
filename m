Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWC3SZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWC3SZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWC3SZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:25:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1041 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751358AbWC3SZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:25:59 -0500
Date: Wed, 29 Mar 2006 00:40:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: add TIOCL_GETKMSGREDIRECT
Message-ID: <20060329004015.GE2762@ucw.cz>
References: <200603301858.26681.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603301858.26681.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-03-06 18:58:26, Rafael J. Wysocki wrote:
> Add TIOCL_GETKMSGREDIRECT needed by the userland suspend tool to get
> the current value of kmsg_redirect from the kernel so that it can save it and
> restore it after resume.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK, FWIW.
-- 
Thanks, Sharp!
