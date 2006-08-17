Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWHQJqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWHQJqn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWHQJqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:46:43 -0400
Received: from colin.muc.de ([193.149.48.1]:27396 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S964789AbWHQJqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:46:42 -0400
Date: 17 Aug 2006 11:46:40 +0200
Date: Thu, 17 Aug 2006 11:46:40 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] Support piping into commands in /proc/sys/kernel/core_pattern
Message-ID: <20060817094640.GA3173@muc.de>
References: <20060814127.183332000@suse.de> <20060814112732.684D313BD9@wotan.suse.de> <20060816084354.GF24139@kroah.com> <20060816111801.0fc5093e.ak@muc.de> <20060816111025.1ab702a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816111025.1ab702a1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It doens't sounds like there's particularly strong userspace "pull" for
> this feature?

Several people from the embedded area wrote me privately
it would be useful for them. Also I think once it's in the main kernel
there will be more incentive for user space to use it and I'm optimistic
it will get some adoption (ok I guess I should write some better
documentation, but there was no obvious place for it)

-Andi

