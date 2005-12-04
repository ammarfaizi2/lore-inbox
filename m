Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVLDXmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVLDXmB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVLDXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:42:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14468 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932095AbVLDXmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:42:00 -0500
Date: Mon, 5 Dec 2005 00:41:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][Fix][mm] swsusp: fix handling of highmem
Message-ID: <20051204234125.GC5509@elf.ucw.cz>
References: <200512042346.11731.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512042346.11731.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following two patches are necessary to fix the way in which swsusp (in
> the current -mm) handles highmem.
> 
> The patches have been acked by Pavel (Pavel, please confirm).

ACK and thakns. (Sorry if you get this twice).
								Pavel
-- 
Thanks, Sharp!
