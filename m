Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVATBGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVATBGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVATBGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:06:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:46799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262015AbVATBGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:06:53 -0500
Date: Wed, 19 Jan 2005 17:06:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [patch] Job - inescapable job containers
Message-Id: <20050119170628.2429c41e.akpm@osdl.org>
In-Reply-To: <200501192343.j0JNhIW17763@dbear.engr.sgi.com>
References: <200501192343.j0JNhIW17763@dbear.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Limin Gu <limin@dbear.engr.sgi.com> wrote:
>
>  Could you consider this for inclusion in the mm tree?
>  The Job patch has been posted a few times, and I've addressed
>  the issues others raised.

I'm totally not in a position to evaluate the completeness, desirability,
interest-level, etc of this patch, I'm afraid.  This is an opportunity for
other stakeholders to weigh in..

A similar thing happened last year with the "enhanced system accounting"
patch.  I tossed it back to lse-tech, asking the people there to come up
with some sort of agreed framework.  After several months we have one small
patch for enhanced accounting which nothing actually uses yet.

So things aren't working very well.  What's up?
