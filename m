Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWHJLeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWHJLeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWHJLeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:34:25 -0400
Received: from msr36.hinet.net ([168.95.4.136]:15856 "EHLO msr36.hinet.net")
	by vger.kernel.org with ESMTP id S1161176AbWHJLeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:34:24 -0400
Message-ID: <023201c6bc70$57413c90$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Francois Romieu" <romieu@fr.zoreil.com>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
References: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw> <20060727190707.GA24157@electric-eye.fr.zoreil.com> <002701c6bc24$2a9f10f0$4964a8c0@icplus.com.tw> <44DB1727.2000502@pobox.com>
Subject: Re: Hello, We had some patch need to submit for sundance.c
Date: Thu, 10 Aug 2006 19:30:10 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:

    I will use sundance.c in this tree to generate patch files.

Thanks for this information.

Jesse

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: "Francois Romieu" <romieu@fr.zoreil.com>;
<linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>; "Andrew Morton"
<akpm@osdl.org>
Sent: Thursday, August 10, 2006 7:23 PM
Subject: Re: Hello, We had some patch need to submit for sundance.c


Jesse Huang wrote:
> Dear All:
>
> We had some patch need to submit. Would you tell me where to get current
> sundance.c for myself to generate those patch files.
>
> Sorry, I only got this link:
>
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=f13b2a195c708fe32d8c53d05988875a51bd52e1;hb=1668b19f75cb949f930814a23b74201ad6f76a53;f=drivers/net/sundance.c

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


