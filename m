Return-Path: <linux-kernel-owner+w=401wt.eu-S965097AbWLMTZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWLMTZj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWLMTZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:25:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33232 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965097AbWLMTZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:25:38 -0500
Date: Wed, 13 Dec 2006 11:25:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Proper backlight selection for
 fbdev drivers
Message-Id: <20061213112508.e1bad3fa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131442440.4484@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
	<20061213000029.edd9c91e.akpm@osdl.org>
	<Pine.LNX.4.64.0612131442440.4484@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 14:58:26 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> The problem is the overlap of the patches 
> 
> fbdev-update-after-backlight-argument-change.diff
> proper-backlight-selection-forfbdev-drivers.patch
> 
> The machine_is change is in the argument change patch. It should be in 
> this patch. I can send updates of both patches.

oh ok, I wondered why -mm1 worked OK.  Let me put things back...
