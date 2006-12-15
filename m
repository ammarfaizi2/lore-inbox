Return-Path: <linux-kernel-owner+w=401wt.eu-S1752051AbWLOMKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWLOMKJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 07:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWLOMKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 07:10:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2984 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752044AbWLOMKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 07:10:07 -0500
Date: Fri, 15 Dec 2006 12:09:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, jesper.juhl@gmail.com,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Message-ID: <20061215120942.GA4551@ucw.cz>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Add some kernel coding style comments, mostly pulled from emails
> by Andrew Morton, Jesper Juhl, and Randy Dunlap.
...
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Acked-by: Jesper Juhl <jesper.juhl@gmail.com>

ACK.

> +Use one space around (on each side of) most binary and ternary operators,
> +such as any of these:
> +	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :

Actually, this should not be hard rule. We want to allow

	j = 3*i + l<<2;
							Pavel
-- 
Thanks for all the (sleeping) penguins.
