Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280646AbRKBKpY>; Fri, 2 Nov 2001 05:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280647AbRKBKpO>; Fri, 2 Nov 2001 05:45:14 -0500
Received: from [200.248.92.2] ([200.248.92.2]:41990 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S280646AbRKBKpB>; Fri, 2 Nov 2001 05:45:01 -0500
Message-Id: <200111021140.JAA24493@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre6 kswapd race
Date: Fri, 2 Nov 2001 08:41:58 -0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org> <3BE04DE8.F012C592@pobox.com> <3BE050A6.90404@mail.myrealbox.com>
In-Reply-To: <3BE050A6.90404@mail.myrealbox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After 1 day 18 hours of uptime running my Database Server, 2.4.14-pre6 enters 
in race (kswapd), the machine response to ping, I'm running top a I saw 
kswapd going to 100% CPU use.

Maybe 2.4.14-pre7 solve this?



Thanks


Andre
