Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVG1Rne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVG1Rne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVG1R2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:28:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbVG1R0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:26:37 -0400
Date: Thu, 28 Jul 2005 10:25:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [ALSA PATCH] 1.0.9b+
Message-Id: <20050728102525.234e6511.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela <perex@suse.cz> wrote:
>
> Linus, please do an update from:
> 
>    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> 
> ...
>   65 files changed, 5059 insertions(+), 1122 deletions(-)

The git-alsa.patch in -mm which I obtain from
master.kernel.org:/pub/scm/linux/kernel/git/perex/alsa-current.git is
empty.  So we're now wanting to merge 4,000 lines of unreviewed code which
hasn't been tested in -mm at approximately the -rc4 stage.

We need to become much better at this.
