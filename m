Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317000AbSEWUe3>; Thu, 23 May 2002 16:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSEWUe2>; Thu, 23 May 2002 16:34:28 -0400
Received: from rtcom.teracom.com.br ([200.250.45.33]:44553 "HELO
	teracom.com.br") by vger.kernel.org with SMTP id <S317000AbSEWUe2>;
	Thu, 23 May 2002 16:34:28 -0400
Message-ID: <20020523203304.23783.qmail@teracom.com.br>
From: Vinicius <vinicius@teracom.com.br>
To: linux-kernel@vger.kernel.org
Subject: Problem: Error on get some pages in kernel 2.4.18 with any squid version using proxy
Date: Thu, 23 May 2002 20:33:04 GMT
Mime-version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An error occurr when i tried to use proxy in kernel 2.4.18. When i tried to
reach some urls like http://www.itau.com.br or http://www.pactum.com.br the
request just didnt got the page.

I tried all possible compilations of kernel and it still didnt got it.

But changing the kernel to older versions like 2.4.7-10 or 2.2.20 it works,
without change any configuration of squid.

Please, take a look on this.

Rewards,

Vinicius Garcia Mommensohn
Maringa - PR - Brazil
www.teracom.com.br
