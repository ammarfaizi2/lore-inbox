Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUKAJ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUKAJ3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUKAJ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:29:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43674 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261676AbUKAJ32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:29:28 -0500
Date: Mon, 1 Nov 2004 10:29:28 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041101092928.GD10059@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <20041029101758.GA7278@atrey.karlin.mff.cuni.cz> <20041029032420.327d65dd.akpm@osdl.org> <20041029200907.GB18508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029200907.GB18508@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 29, 2004 at 03:24:20AM -0700, Andrew Morton wrote:
>  > OK, fair enough.  I'll merge the patch if you talk suse into enabling
>  > sysrq-T and sysrq-P and sysrq-M by default ;)
>  
> you already have those available if /proc/sys/kernel/sysrq is 0.
> 
> alt-scrolllock / ctrl-scrolllock / shift-scrolllock.
  I admit I didn't know that but I also just found out that there's no
scrolllock on my notebook keyboard... But anyway thanks for info.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
