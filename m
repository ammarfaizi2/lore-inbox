Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVBWFud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVBWFud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 00:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVBWFuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 00:50:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:57800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261313AbVBWFu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 00:50:28 -0500
Date: Tue, 22 Feb 2005 21:50:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Warning of redefined NR_OPEN
Message-ID: <20050223055023.GD21662@shell0.pdx.osdl.net>
References: <1109134828.8506.118.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109134828.8506.118.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcel Holtmann (marcel@holtmann.org) wrote:
> when compiling the latest 2.6 tree from the Bitkeeper repository, I get
> a lot of these:
> 
>   CC      init/main.o
> In file included from include/linux/fs.h:202,
>                  from include/linux/proc_fs.h:6,
>                  from init/main.c:17:
> include/linux/limits.h:4:1: warning: "NR_OPEN" redefined

Yup, although it's been fixed in bk.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
