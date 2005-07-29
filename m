Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVG2GLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVG2GLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVG2GLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:11:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262426AbVG2GLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:11:31 -0400
Date: Thu, 28 Jul 2005 23:10:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050728231029.0c0026bc.akpm@osdl.org>
In-Reply-To: <159960000.1122616883@[10.10.2.4]>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<159960000.1122616883@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> NUMA-Q boxes are still crashing on boot with -mm BTW. Is the thing we 
> identified earlier with the sched patches ...
> 
> http://test.kernel.org/9398/debug/console.log

Oh, thanks.  That's about 8,349 bugs ago and I'd forgotten.

> Works with mainline still (including -rc4) ... hopefully those patches 
> aren't on their way upstream anytime soon ;-)

Well can you identify the offending patch(es)?  If so, I'll exterminate them.

