Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWDKWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWDKWgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWDKWgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:36:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbWDKWgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:36:38 -0400
Date: Tue, 11 Apr 2006 15:39:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew L Foster <mfoster167@yahoo.com>
Cc: linux-kernel@vger.kernel.org, mfoster167@yahoo.com
Subject: Re: BUG 2.6.16-git20 prelink
Message-Id: <20060411153903.47854b0f.akpm@osdl.org>
In-Reply-To: <20060411203128.55352.qmail@web51011.mail.yahoo.com>
References: <20060411203128.55352.qmail@web51011.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew L Foster <mfoster167@yahoo.com> wrote:
>
> My machine was hung this morning, had to reboot, found the following in the log. Please CC me on
> any replies since I am not subscribed to the list.
> 
> Apr 11 04:03:23 localhost kernel: BUG: unable to handle kernel paging request at virtual address
> 04000000

Single bit error: probably a hardware failure.

Is this a new machine?  Or a very old one?  Recent memory upgrade?

Please run memtest86 on it for 24 hours.
