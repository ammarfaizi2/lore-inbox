Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVFHCot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVFHCot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVFHCos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:44:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:10884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262075AbVFHCoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:44:44 -0400
Date: Tue, 7 Jun 2005 19:44:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Schmid <webmaster@rapidforum.com>
Cc: nickpiggin@yahoo.com.au, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-Id: <20050607194428.646be75f.akpm@osdl.org>
In-Reply-To: <42A65759.8050507@rapidforum.com>
References: <4229E805.3050105@rapidforum.com>
	<422BAAC6.6040705@candelatech.com>
	<422BB548.1020906@rapidforum.com>
	<422BC303.9060907@candelatech.com>
	<422BE33D.5080904@yahoo.com.au>
	<422C1D57.9040708@candelatech.com>
	<422C1EC0.8050106@yahoo.com.au>
	<422D468C.7060900@candelatech.com>
	<422DD5A3.7060202@rapidforum.com>
	<422F8A8A.8010606@candelatech.com>
	<422F8C58.4000809@rapidforum.com>
	<422F9259.2010003@candelatech.com>
	<422F93CE.3060403@rapidforum.com>
	<20050309211730.24b4fc93.akpm@osdl.org>
	<4231B95B.6020209@rapidforum.com>
	<4231ED18.2050804@candelatech.com>
	<4231F112.60403@rapidforum.com>
	<1110775215.5131.17.camel@npiggin-nld.site>
	<423518C7.10207@rapidforum.com>
	<1110776689.5131.37.camel@npiggin-nld.site>
	<42A65759.8050507@rapidforum.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid <webmaster@rapidforum.com> wrote:
>
>  This makes me seriously to despair.... the bug/lock/freeze is still there in 2.6.12rc6 ...
> 
>  I am seriously offering 1000 dollars to the one who fixes this. (No Joke. I NEED that fixed. If you 
>  want me to give that money to some organization, tell me.)
> 
>  Please come back to me if you need more details or tell me what I can do to help you track this 
>  down. Review all postings before please. Its a vm-lock because even opening a /proc file needs 
>  around 20-30 seconds...

Did we have a test program which someone can run to reproduce this?

We'll pay you $1,000 to write it ;)
