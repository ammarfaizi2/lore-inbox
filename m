Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUCaDlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 22:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCaDly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 22:41:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:50324 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261717AbUCaDlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 22:41:53 -0500
Date: Tue, 30 Mar 2004 19:41:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Message-Id: <20040330194149.4f1451bc.akpm@osdl.org>
In-Reply-To: <20040331030921.GA2143@dualathlon.random>
References: <20040331030921.GA2143@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> In the meantime this is already mergeable in -mm if Andrew is
>  interested.

It's a bit early for that, I feel.  I'd like to see thing settle down a
little more at your end first, then see that Rajesh, Hugh and if possible
Ingo have had a good go through everything.

And then there are the mechanics of swallowing a largely-undocumented
4,600-line patch which touches 60 files and tosses 30-odd rejects across 16
files.

We have a way to go yet.  Once I've dumped a lot of the current pending
stuff into 2.6.6-early we'll be in better shape.

