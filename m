Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbUJ0Amh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbUJ0Amh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUJ0AjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:39:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:28854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261593AbUJ0Ai5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:38:57 -0400
Date: Tue, 26 Oct 2004 17:42:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-Id: <20041026174237.44ab2b23.akpm@osdl.org>
In-Reply-To: <20041027002536.GM14325@dualathlon.random>
References: <20041025170128.GF14325@dualathlon.random>
	<Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com>
	<20041026015825.GU14325@dualathlon.random>
	<417DC8F2.7000902@yahoo.com.au>
	<20041026040429.GW14325@dualathlon.random>
	<417DCFDD.50606@yahoo.com.au>
	<20041027002536.GM14325@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> I don't see any other equivalent teminology besides my "classzone" word
> existing,

I'll confess that I've never understood what "classzone" _means_.  Is it "a
zone from amongst several classes" or what?

If it was "zone_class" then it might mean "a particular classification of
zones".  Maybe that's what you meant?

I think a lot of other mm hackers share my confusion, which is why
"classzone" has been trickling away.  But yeah, we haven't been replacing it
with anything very useful.
