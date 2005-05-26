Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVEZA3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVEZA3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVEZA3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 20:29:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:7344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbVEZA3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 20:29:15 -0400
Date: Wed, 25 May 2005 17:29:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc1-mm2
Message-Id: <20050525172949.0d5e637c.akpm@osdl.org>
In-Reply-To: <200503242331.46985.rjw@sisk.pl>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<1111682812.23440.6.camel@mindpipe>
	<20050324121722.759610f4.akpm@osdl.org>
	<200503242331.46985.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> 
> BTW, on 2.6.12-rc1-mm2 I can't rmmod the snd_intel8x0 module (the process
> goes into the D state immediately), which did not happen before.  This is 100%
> reproducible, on two different AMD64-based boxes, with different sound chips.

Is this bug stil present in 2.6.12-rc5-mm1 or 2.6.12-rc5?

Thanks.
