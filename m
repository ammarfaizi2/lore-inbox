Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWIUX7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWIUX7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIUX7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:59:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbWIUX7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:59:21 -0400
Date: Thu, 21 Sep 2006 16:59:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060921165918.af7a5a63.akpm@osdl.org>
In-Reply-To: <358882397.20533@ustc.edu.cn>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<358882397.20533@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 07:46:37 +0800
Fengguang Wu <fengguang.wu@gmail.com> wrote:

> On Wed, Sep 20, 2006 at 01:54:38PM -0700, Andrew Morton wrote:
> > 
> >  The readahead code is complex, I'm unconvinced that it has a lot of benefit
> >  and Wu has gone quiet.  Will drop.
> 
> Sorry, I've been putting efforts to meet the deadline of the google
> SoC project "Rapid linux desktop startup through pre-caching", which
> still can not be called success for now. And there's my pending paper
> work...

Oh, OK.

That's a neat thing to be working on.

> I should be able to come back and concentrate on the readahead patch
> after one month, whether it be dropped for now.  I guess it can be
> further improved in complexity and performance.  It also needs a good
> document for the overall design and benefits.  And sure the
> performance numbers :-)

I'll hang onto the patches then - they're causing little maintenance
trouble for me.

