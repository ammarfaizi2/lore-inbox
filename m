Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUGKEjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUGKEjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 00:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUGKEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 00:39:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:36040 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266494AbUGKEjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 00:39:39 -0400
Date: Sat, 10 Jul 2004 21:38:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       tim.bird@am.sony.com, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-Id: <20040710213824.501545fb.akpm@osdl.org>
In-Reply-To: <20040710234459.A26981@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com>
	<20040710115413.A31260@mail.kroptech.com>
	<20040710142800.A5093@mail.kroptech.com>
	<200407101319.31147.dtor_core@ameritech.net>
	<099101c466ba$7d75aa30$03c8a8c0@kroptech.com>
	<20040710182527.47534358.akpm@osdl.org>
	<20040710234459.A26981@mail.kroptech.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin <akropel1@rochester.rr.com> wrote:
>
> Actually, there are no ifdefs at all (unless there are some
>  auto-generated ones I don't know about).

OK, I should have looked and not guessed ;)

>  Thanks for your feedback. Here's a patch implementing your suggestions.

Thanks.  Tim, could you please review-n-test this?
