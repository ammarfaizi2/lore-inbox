Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292316AbSCTDon>; Tue, 19 Mar 2002 22:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311459AbSCTDoe>; Tue, 19 Mar 2002 22:44:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:4506 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S292316AbSCTDoV>; Tue, 19 Mar 2002 22:44:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Mar 2002 19:49:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] /dev/epoll update ...
Message-ID: <Pine.LNX.4.44.0203191943090.939-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*) Export correct symbols from fcblist.c so eventpoll can be used
	as a module ( thx to  Paul P Komkoff Jr  )
*) Added GPL modlicense to eventpoll.c ( thx to  Paul P Komkoff Jr  )
*) Added timeout unsigned long overflow check ( thx to  Ossama Othman  )


http://www.xmailserver.org/linux-patches/nio-improve.html#patches




- Davide






