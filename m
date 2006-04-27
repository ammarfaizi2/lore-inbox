Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWD0SWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWD0SWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWD0SWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:22:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbWD0SWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:22:23 -0400
Date: Thu, 27 Apr 2006 11:17:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       v4l-dvb-maintainer@linuxtv.org
Subject: Re: [-mm patch] fix VIDEO_DEV=m, VIDEO_V4L1_COMPAT=y
Message-Id: <20060427111718.570d5650.akpm@osdl.org>
In-Reply-To: <20060427175727.GH3570@stusta.de>
References: <20060427014141.06b88072.akpm@osdl.org>
	<20060427175727.GH3570@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Below is the patch I sent you after I discovered the bug 
>  in 2.6.17-rc1-mm3. Is there any reason why you didn't merge my patch?

I saw you'd cc'ed the maintainer on it.
