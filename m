Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUIHUAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUIHUAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268671AbUIHUAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:00:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13788 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268474AbUIHT77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:59:59 -0400
Subject: Re: [PATCH 3/3] sched: cpu hotplug notifier for updating sched
	domains
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <413F01C7.3060008@yahoo.com.au>
References: <413EFFFB.5050902@yahoo.com.au> <413F0070.2020104@yahoo.com.au>
	 <413F01C7.3060008@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1094658219.14438.2.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 10:43:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 07:57, Nick Piggin wrote:
> 3/3
> 
> This builds on (and is mostly) Nathan's work. I have messed with a few
> things though. It survives some cpu hotplugging on i386. Nathan, can you
> give this a look? Do you agree with the general direction?

Yep, looks good to me, and I gave it a sniff test on ppc64.  Thanks.

Nathan


