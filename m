Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271694AbTG2OCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271712AbTG2OCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:02:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:21185 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S271694AbTG2OBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:01:09 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.0-test2
Date: Tue, 29 Jul 2003 16:01:01 +0200
User-Agent: KMail/1.5.2
Cc: herbert@gondor.apana.org.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307291601.01730.christian@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Herbert Xu:
>   o [IPSEC]: Make reqids 32-bits

Is this the reason why I can connect
2.6.0-test1 with 2.6.0-test1
2.6.0-test2 with 2.6.0-test2

but 2.6.0-test1 cannot connect to 2.6.0-test2 with ipsec?


cheers

Christian

