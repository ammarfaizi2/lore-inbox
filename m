Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVCPXLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVCPXLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVCPXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:11:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:8065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262874AbVCPXJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:09:21 -0500
Date: Wed, 16 Mar 2005 15:09:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make gconfig build again
Message-Id: <20050316150901.3b5e4ba5.akpm@osdl.org>
In-Reply-To: <1111013866l.23273l.0l@werewolf.able.es>
References: <20050316040654.62881834.akpm@osdl.org>
	<1110985632l.8879l.0l@werewolf.able.es>
	<20050316132600.3f6e4df2.akpm@osdl.org>
	<1111013866l.23273l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
>  The patch caused those little pixmap buttons across the top of the main
>  > window to vanish when using gtk+-1.2.10-28.1.  See
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg.
>  > 
>  > I now note that scripts/kconfig/gconf.c doesn't compile at all with the
>  > above backout patch.  Drat.
>  > 
> 
>  This is enough to make it compile:

OK..  I still don't have pixmaps over "Collapse" and "Expand" though.

And I assume we're again broken with gtk-2.4?  What is the nature of that
breakage?

