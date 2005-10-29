Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVJ2AM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVJ2AM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVJ2AM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:12:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750887AbVJ2AM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:12:57 -0400
Date: Fri, 28 Oct 2005 17:12:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand updates for 2.6.14
Message-Id: <20051028171218.2b8e71e7.akpm@osdl.org>
In-Reply-To: <523bmlqkg0.fsf@cisco.com>
References: <523bmlqkg0.fsf@cisco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
>  43 files changed, 2675 insertions(+), 1773 deletions(-)

That's rather a lot of code.  AFAIK it hasn't been past linux-kernel.  It
hasn't been in -mm.

Can we please

a) arrange for the current infiniband devel tree to be included in -mm and

b) arrange for infiniband patches to get wider review than this?

Thanks.
