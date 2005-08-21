Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVHUVE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVHUVE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVHUVE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:04:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52936 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751094AbVHUVEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:04:55 -0400
Date: Sun, 21 Aug 2005 12:46:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: samba@samba.org, linux-kernel@vger.kernel.org, Urban.Widmark@enlight.net,
       Steven French <sfrench@us.ibm.com>
Subject: Re: New maintainer needed for the Linux smb filesystem
Message-Id: <20050821124657.22f1a095.akpm@osdl.org>
In-Reply-To: <20050821143457.GA5726@stusta.de>
References: <20050821143457.GA5726@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Since Urban Widmark was not active for some time, and I didn't have any 
> success trying to reach him, it seems we need a new maintainer for the 
> smb filesystem in the Linux kernel.
> 
> Is there anyone who both feels qualified and wants to become the new 
> maintainer?
> 

Yes, it's a poor situation.  That driver seems to have quite a few problems.

I was hoping that by now we could simply deprecate smbfs and tell people to
use CIFS, but I'm not sure that CIFS is ready for that yet.

Steve, what's your take?  Does CIFS offer a 100% superset of smbfs
capabilities?

Thanks.
