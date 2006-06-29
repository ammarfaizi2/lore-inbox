Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWF2Jx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWF2Jx0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWF2Jx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:53:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751586AbWF2JxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:53:24 -0400
Date: Thu, 29 Jun 2006 02:53:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [ALSA PATCH] HG repo sync
Message-Id: <20060629025306.455c89ce.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0606291138030.10575@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0606291138030.10575@tm8103-a.perex-int.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 11:39:35 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> Linus, please do an update from:
> 
>   http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
>

As far as I can tell none of this has had any testing in -mm.  The tree I
get from
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/perex/alsa-current.git
has quite different changes in it.

What can we do about this?
