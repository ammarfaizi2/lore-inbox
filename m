Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUBQCaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 21:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUBQCaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 21:30:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:40092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265732AbUBQCap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 21:30:45 -0500
Date: Mon, 16 Feb 2004 18:31:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-Id: <20040216183143.512c3d5e.akpm@osdl.org>
In-Reply-To: <20040216190927.GA2969@us.ibm.com>
References: <20040216190927.GA2969@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
>  The attached patch to make invalidate_mmap_range() non-GPL exported
>  seems to have been lost somewhere between 2.6.1-mm4 and 2.6.1-mm5.
>  It still applies cleanly.  Could you please take it up again?

I don't have any particular opinions either way but I do recall there was
some disquiet last time this came up.  I'm sure someone will remind us ;)

