Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136452AbREINzE>; Wed, 9 May 2001 09:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136460AbREINyz>; Wed, 9 May 2001 09:54:55 -0400
Received: from [212.115.175.146] ([212.115.175.146]:40432 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S136452AbREINyi>; Wed, 9 May 2001 09:54:38 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F12C8@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: weird
Date: Wed, 9 May 2001 15:54:33 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my dual pii system, I get these messages:
May  9 15:53:18 marlboro.intranet.vanheusden.com kernel: KERNEL: assertion
(tp->lost_out == 0) failed at tcp_input.c(1202):tcp_remove_reno_sacks

Is this worrying?
More info:
marlboro:~$ uname -a
Linux marlboro 2.4.3 #4 SMP Sun May 6 13:23:49 GMT+1 2001 i686 unknown

