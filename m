Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTJRAXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTJRAXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:23:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:1501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263529AbTJRAXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:23:54 -0400
Date: Fri, 17 Oct 2003 17:24:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: AIO and DIO testing on 2.6.0-test7-mm1
Message-Id: <20031017172400.522486e7.akpm@osdl.org>
In-Reply-To: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> On AIO test7 still gives me oopses:

Oh crap, that means I need to rebase those two patches on top of -linus,
not on top of -linus+AIOstuff.

I shall do that, thanks.
