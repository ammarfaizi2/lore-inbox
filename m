Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965343AbWI0FTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965343AbWI0FTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbWI0FTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:19:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965339AbWI0FTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:19:30 -0400
Date: Tue, 26 Sep 2006 22:09:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: perfmon@napali.hpl.hp.com, perfctr-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-Id: <20060926220951.39bd344f.akpm@osdl.org>
In-Reply-To: <20060926143420.GF14550@frankl.hpl.hp.com>
References: <20060926143420.GF14550@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 07:34:20 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> I have released another version of the perfmon new code base package.
> This version of the kernel patch is relative to 2.6.18. This longer
> than usual delay between releases comes from the large amount of changes
> than went into this new release following the feedback I got on LKML. As
> a result, the code has improved.

Thanks for doing that.

Would it be possible to get an accounting of the disposition of the various
review comments?  Of the "yes I did that" or "OK, but I'll do it later" or
"no, you're an idiot" form?


