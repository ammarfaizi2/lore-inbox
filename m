Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVCBVe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVCBVe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVCBVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:34:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:18864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262552AbVCBVdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:33:01 -0500
Date: Wed, 2 Mar 2005 13:32:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steffen Michalke <StMichalke@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange crashes of kernel v2.6.11
Message-Id: <20050302133239.2529a8cb.akpm@osdl.org>
In-Reply-To: <1109787428.6828.14.camel@pinky.local>
References: <1109787428.6828.14.camel@pinky.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Michalke <StMichalke@web.de> wrote:
>
> I recently upgraded from linux kernel v2.6.10 to v2.6.11.
>  Some programs like evolution 2.0 and leafnode2 crash the whole system
>  immediatedly now.
> 
>  I would like to provide some further information if i could gather them.

We'd need to see an oops trace.  Did nothing hit the kernel logs?

If not, a serial console would be needed.  It's a bit of a hassle I'm
afraid.

