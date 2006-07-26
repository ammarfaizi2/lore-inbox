Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWGZHJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWGZHJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWGZHJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:09:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37738 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932513AbWGZHJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:09:21 -0400
Date: Wed, 26 Jul 2006 09:08:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] update I/O sched Kconfig help texts - CFQ is now default, not AS.
Message-ID: <20060726070857.GR4044@suse.de>
References: <200607252218.01663.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607252218.01663.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25 2006, Jesper Juhl wrote:
> Change I/O scheduler description to correctly show CFQ as being the default
> scheduler and not the anticipatory scheduler that previously was default.

Thanks, that needs doing. I'll compliment your change with a fuller
description of CFQ, it's somewhat outdated.

-- 
Jens Axboe

