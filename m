Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbULSXIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbULSXIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 18:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULSXIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 18:08:39 -0500
Received: from webmail.sub.ru ([213.247.139.22]:29967 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261351AbULSXIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 18:08:36 -0500
From: Mikhail Ramendik <mr@ramendik.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Mon, 20 Dec 2004 02:08:20 +0300
User-Agent: KMail/1.7.1
Cc: lista4@comhem.se, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2> <41C6073B.6030204@yahoo.com.au>
In-Reply-To: <41C6073B.6030204@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200208.20318.mr@ramendik.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> It would be nice to find out what is going on before 2.6.10 gets released,
> but Mats isn't going to be able to do any more testing for the moment.
> Andrew, what should we do?

I am ready to do the testing with the memory eater, and with "a complie in the 
background plus the memory eater". 

I'm not as good at kernel code management as Mats and did not do the 
regression tests on -bk and past -rc versions, nor can I duplicate the X hack 
on 2.6.9-rc1. But if you give me a patch against any numbered version 
(2.6.8.1, 2.6.9) or against 2.6.10-rc3 , I'll gladly test it, with probably 
no more than 24 h response time ;)

-- 
Yours, Mikhail Ramendik

