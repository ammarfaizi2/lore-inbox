Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWHBUTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWHBUTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHBUTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:19:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57020 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932208AbWHBUTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:19:49 -0400
Date: Wed, 2 Aug 2006 22:19:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] swsusp: Reorder memory-allocating functions
Message-ID: <20060802201931.GD8124@elf.ucw.cz>
References: <200608021842.21774.rjw@sisk.pl> <200608021853.47040.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608021853.47040.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-02 18:53:46, Rafael J. Wysocki wrote:
> Move some functions in kernel/power/snapshot.c to a better place
> (in the same file) and introduce free_image_page() (will be necessary in the
> future).

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
