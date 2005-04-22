Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVDVDwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVDVDwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 23:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVDVDwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 23:52:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261934AbVDVDwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 23:52:00 -0400
Date: Fri, 22 Apr 2005 05:51:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Robert Love <rml@novell.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Mr Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] kstrdup: implementation
Message-ID: <20050422035156.GH3828@stusta.de>
References: <1114141276.6973.87.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114141276.6973.87.camel@jenny.boston.ximian.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 11:41:15PM -0400, Robert Love wrote:

> Rusty and I's LCA kernel tutorial again brought up kstrdup().  Let's
> close this never ending saga and provide a standard kernel
> implementation.
>...
 
This is a good example why development against Linus' tree is ofter 
pointless:

A similar patch is already in -mm.

> Best,
> 
> 	Robert Love
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

