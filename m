Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRGEB6v>; Wed, 4 Jul 2001 21:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbRGEB6m>; Wed, 4 Jul 2001 21:58:42 -0400
Received: from beasley.gator.com ([63.197.87.202]:54284 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266606AbRGEB63>; Wed, 4 Jul 2001 21:58:29 -0400
From: "George Bonser" <george@gator.com>
To: <kern@wolf.ericsson.net.nz>, <linux-kernel@vger.kernel.org>
Subject: RE: tcp stack tuning and Checkpoint FW1 & Legato Networker
Date: Wed, 4 Jul 2001 19:02:36 -0700
Message-ID: <CHEKKPICCNOGICGMDODJIELKDIAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0107051331190.2882-100000@wolf.ericsson.net.nz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I want to set the tcp_keepalive timer to 60 seconds and understand
> possible implications for Linux.


echo 60 >/proc/sys/net/ipv4/tcp_keepalive_time

????


