Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270220AbRH1DoG>; Mon, 27 Aug 2001 23:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270207AbRH1Dn5>; Mon, 27 Aug 2001 23:43:57 -0400
Received: from web20204.mail.yahoo.com ([216.136.226.59]:36873 "HELO
	web20204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270221AbRH1Dnk>; Mon, 27 Aug 2001 23:43:40 -0400
Message-ID: <20010828034357.50199.qmail@web20204.mail.yahoo.com>
Date: Mon, 27 Aug 2001 20:43:57 -0700 (PDT)
From: Marty Biznatch <mrsamjooky2000@yahoo.com>
Subject: __remove_wait_queue
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging a kernel paging request I found
that the first parameter of __remove_wait_queue
is unused?


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
