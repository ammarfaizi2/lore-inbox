Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUJARFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUJARFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUJARFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:05:46 -0400
Received: from peabody.ximian.com ([130.57.169.10]:36554 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265195AbUJARDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:03:21 -0400
Subject: Re: [patch] make dnotify compile-time configurable
From: Robert Love <rml@novell.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: mpm@selenic.com, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
In-Reply-To: <20041001085823.05adc9b5.rddunlap@osdl.org>
References: <1096611874.4803.18.camel@localhost>
	 <20041001151124.GQ31237@waste.org>
	 <1096644076.7676.6.camel@betsy.boston.ximian.com>
	 <20041001083110.76a58fd2.rddunlap@osdl.org>
	 <1096645479.7676.15.camel@betsy.boston.ximian.com>
	 <20041001085823.05adc9b5.rddunlap@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Oct 2004 13:01:55 -0400
Message-Id: <1096650115.7676.20.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 08:58 -0700, Randy.Dunlap wrote:

> Sorry, that's about all that I was trying to say.  If patches A & B
> are logically separate, don't combine them.  Nothing new there.

In this case I offer A or A&B.

> Well, the patch shouldn't remove dnotify unconditionally, or not
> until we have that elusive stable kernel series that people keep
> mentioning elsewhere.

No patch I posted removes dnotify unconditionally.

	Robert Love


