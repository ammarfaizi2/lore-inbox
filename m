Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTJCWHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTJCWHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:07:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:28136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbTJCWHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:07:53 -0400
Date: Fri, 3 Oct 2003 15:07:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Modica <modica@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: simple mod_timer patch
Message-Id: <20031003150747.451fd845.akpm@osdl.org>
In-Reply-To: <3F7DEABF.2040606@sgi.com>
References: <3F7DEABF.2040606@sgi.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Modica <modica@sgi.com> wrote:
>
> I pulled this back from the 2.6 kernel to reduce some serious contention on the 
> timerlist_lock when I had 8 gigabit cards runnings.
> 

By how much did it reduce contention?
