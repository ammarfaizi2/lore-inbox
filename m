Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUIPX6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUIPX6D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUIPX57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:57:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:1254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268348AbUIPX4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:56:46 -0400
Date: Thu, 16 Sep 2004 17:00:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Suspend2 Merge: Supress various actions/errors while
 suspending [0/5]
Message-Id: <20040916170017.0f14d202.akpm@osdl.org>
In-Reply-To: <1095378659.5897.96.camel@laptop.cunninghams>
References: <1095378659.5897.96.camel@laptop.cunninghams>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> The following patches suppress various actions and errors while we're
> suspending.

Sorry, I'm not in a position to merge all this stuff up.

There's a significant rewrite of the suspend code in -mm and we're having
trouble getting that merged up because Pat has limited time to work on
these things.

Until we get the existing rework settled and Pat has time to look at
suspend2 I'd rather not have to take it on.
