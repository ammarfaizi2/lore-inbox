Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTDXWzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTDXWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:55:06 -0400
Received: from [12.47.58.68] ([12.47.58.68]:22391 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264485AbTDXWzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:55:04 -0400
Date: Thu, 24 Apr 2003 16:04:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: steven roemen <sdroemen1@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm2 bttv oops
Message-Id: <20030424160454.234a1c7c.akpm@digeo.com>
In-Reply-To: <1051225182.976.7.camel@lws04.home.net>
References: <1051153462.997.159.camel@lws04.home.net>
	<20030423213119.26c74759.akpm@digeo.com>
	<1051225182.976.7.camel@lws04.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 23:07:07.0037 (UTC) FILETIME=[3A0704D0:01C30AB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steven roemen <sdroemen1@cox.net> wrote:
>
> the only problem i see now is, migration/0, migration/1 are both in D
> state(via top) or DX (via ps aux), and bringing the load up to ~2.00.

That's OK - it was a slipup whcih Ingo fixed in sched-2.5.68-B2.

