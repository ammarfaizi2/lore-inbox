Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVKQWl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVKQWl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVKQWl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:41:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34719 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964935AbVKQWl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:41:58 -0500
Date: Thu, 17 Nov 2005 23:41:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3][Resend] swsusp: improve freeing of memory
Message-ID: <20051117224141.GB15825@elf.ucw.cz>
References: <200511172322.14735.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511172322.14735.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following series of patches is designed to make swsusp free only as much
> memory as necessary to complete the suspend and not as much as possible.
> This speeds up the suspend substantially and makes the system much more
> responsive after resume, especially on machines with a lot of RAM.
> 
> The patches are against 2.6.15-rc1-mm1.
> 
> They have been acked by Pavel (Pavel please confirm).

Confirmed ;-).
									Pavel
-- 
Thanks, Sharp!
