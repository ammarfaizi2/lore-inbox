Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWECM4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWECM4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWECM4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:56:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965056AbWECM4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:56:48 -0400
Date: Wed, 3 May 2006 05:47:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: beta of pfmon-3.2 available
Message-Id: <20060503054711.b1734c26.akpm@osdl.org>
In-Reply-To: <20060426145636.GA6819@frankl.hpl.hp.com>
References: <20060426145636.GA6819@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 07:56:36 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> I have finally released the first beta version of pfmon-3.2.

perfctr was almost-ready-for-merge.  Then it was decided that perfmon was
the way ahead, and perfctr died.  And now perfmon isn't making progress in
the kernelwards direction (worse, perfmon is getting bigger, thus making a
merge harder and harder).  So we now have the worst of all worlds.

This is a problem.  I'd suggest that at this time we should be
concentrating on getting perfmon merged up rather than adding more stuff to
the out-of-tree version.

IOW: please send patches ;)

And keep sending them.  People want this.

Thanks.
