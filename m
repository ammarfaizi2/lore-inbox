Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWAVUTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWAVUTy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWAVUTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:19:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36812 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751343AbWAVUTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:19:54 -0500
Date: Sun, 22 Jan 2006 21:19:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] swsusp: fix possible lockup in user interface
Message-ID: <20060122201940.GB2043@elf.ucw.cz>
References: <200601221820.15694.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601221820.15694.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 22-01-06 18:20:15, Rafael J. Wysocki wrote:
> Hi,
> 
> The appended patch fixes possible system lockup that may result from
> calling pm_prepare_console() after processes has been frozen.
> 
> Please apply.

Looks okay to me.
								Pavel

-- 
Thanks, Sharp!
