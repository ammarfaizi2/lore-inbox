Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVEZF1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVEZF1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 01:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVEZF1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 01:27:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:27787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261212AbVEZF1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 01:27:20 -0400
Date: Wed, 25 May 2005 22:26:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.6.12rc2: Oops with pcmcia ide flash disk
Message-Id: <20050525222615.7be267a1.akpm@osdl.org>
In-Reply-To: <425BC406.4080005@domdv.de>
References: <425BC406.4080005@domdv.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
>
> 2.6.12rc2 oopses during eject of a pcmcia ide flash disk on x86_64.
> 2.6.11.2 works fine.

Can you please test 2.6.12-rc5?

If that is still buggy, please test 2.6.12-rc5-mm1, or
2.6.12-rc5+ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/broken-out/mystery-ide-fix.patch

Thanks.

