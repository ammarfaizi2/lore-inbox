Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbRF0Emm>; Wed, 27 Jun 2001 00:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265256AbRF0Emb>; Wed, 27 Jun 2001 00:42:31 -0400
Received: from nwcst31h.netaddress.usa.net ([204.68.23.63]:52967 "HELO
	nwcst318.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S265255AbRF0EmW> convert rfc822-to-8bit; Wed, 27 Jun 2001 00:42:22 -0400
Message-ID: <20010627044221.15801.qmail@nwcst318.netaddress.usa.net>
Date: 26 Jun 2001 22:42:21 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Process creating
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all
                      I have in a confusion regarding the creation of
processes by the kernel. Let I have two processes P1 and P2, both are childs
of P0. I want to know the following facts regarding P1 and P2. I have created
two processes by forking. Everyone knows that when P1 and P2 created, they
have different process spaces. 
1  If I point  to a address 0x434343 in P1 and  P2, will it point to the  
same memory area.
2  If not, I need two processes to use same process area, how to do that
3  Will linux kernel support threading
                            Actually I first thought about shared memory. But
for my application, I need huge memory area upto 50MB or more. So 50MB of
shared memory is no good. So I looking for any other alternatives

                       by
                                  Blesson


