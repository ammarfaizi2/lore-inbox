Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTHJUcA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270663AbTHJUcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:32:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:64988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270659AbTHJUb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:31:59 -0400
Date: Sun, 10 Aug 2003 13:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "S.Coffin" <scoffin@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeatable hard crash with 2.6.0.test[123]
Message-Id: <20030810133156.58b89221.akpm@osdl.org>
In-Reply-To: <200308101844.h7AIiDhN001691@yawn.gv.com>
References: <200308101844.h7AIiDhN001691@yawn.gv.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"S.Coffin" <scoffin@comcast.net> wrote:
>
> Attached is the ksymoops output from my "java-exit" panic.  Let me
>  know if there is anything more I can do to help solve this one

OK.  Multiple fixes in this area have recently been added to -mm kernels by
various fine folk.  Could you please test

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1


