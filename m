Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWHJLX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWHJLX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWHJLX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:23:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61147 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161169AbWHJLX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:23:26 -0400
Message-ID: <44DB1727.2000502@pobox.com>
Date: Thu, 10 Aug 2006 07:23:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Hello, We had some patch need to submit for sundance.c
References: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw> <20060727190707.GA24157@electric-eye.fr.zoreil.com> <002701c6bc24$2a9f10f0$4964a8c0@icplus.com.tw>
In-Reply-To: <002701c6bc24$2a9f10f0$4964a8c0@icplus.com.tw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> Dear All:
> 
> We had some patch need to submit. Would you tell me where to get current
> sundance.c for myself to generate those patch files.
> 
> Sorry, I only got this link:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=f13b2a195c708fe32d8c53d05988875a51bd52e1;hb=1668b19f75cb949f930814a23b74201ad6f76a53;f=drivers/net/sundance.c

You need to install the "git" software package, and then check out the 
"upstream" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

Then provide patches against the drivers/net/sundance.c driver found there.

git software download: http://www.kernel.org/pub/software/scm/git/
git overview: http://git.or.cz/
git tutorial: http://www.kernel.org/pub/software/scm/git/docs/tutorial.html
git man pages: http://www.kernel.org/pub/software/scm/git/docs

Thanks,

	Jeff


