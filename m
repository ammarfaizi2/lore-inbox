Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUJGVG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUJGVG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUJGS1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:27:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:5833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267433AbUJGSUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:20:12 -0400
Date: Thu, 7 Oct 2004 11:18:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007111816.73ed22c9.akpm@osdl.org>
In-Reply-To: <41652415.A1E987F1@tv-sign.ru>
References: <41652415.A1E987F1@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Andrew, i think fix-of-stack-dump-in-soft-hardirqs* have problems.
>  see http://marc.theaimsgroup.com/?l=linux-kernel&m=109681898321430
> 
>  Do you seeing any flaws in more simple alternative patch?
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=109687808210397
> 
>  I sent this description, but haven't got any responce
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=109688178912849

I wasn't aware that there was any problem with Kirill's patch.  And I
couldn't work out how to get your patches to apply so I left things as they
are.

Please send a fresh patch against Linus's current tree.  Please include
with that a concise description of the problem and the solution.

Thanks.

