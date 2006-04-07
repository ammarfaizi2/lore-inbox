Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWDGJtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWDGJtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDGJtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:49:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932404AbWDGJtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:49:19 -0400
Date: Fri, 7 Apr 2006 02:47:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, nickpiggin@yahoo.com.au,
       pwil3058@bigpond.net.au, kernel@kolivas.org
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Message-Id: <20060407024758.22417917.akpm@osdl.org>
In-Reply-To: <1144402690.7857.31.camel@homer>
References: <1144402690.7857.31.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> Problem:

I don't know what to do with all these patches you keep sending.

a) The other sched guys seem to be hiding and

b) I'm still sitting on smpnice, and I don't think that's had all its
   problems ironed out yet, so putting the interactivity things in there as
   well will complicate getting that sorted out.

But it's always nice to get email from you ;)
