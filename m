Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSAZGrO>; Sat, 26 Jan 2002 01:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSAZGq6>; Sat, 26 Jan 2002 01:46:58 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:4318 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288851AbSAZGqm>; Sat, 26 Jan 2002 01:46:42 -0500
Message-ID: <3C5251BD.7000208@earthlink.net>
Date: Sat, 26 Jan 2002 00:50:37 -0600
From: "A. Castro" <btcal@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux select() bug hit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC'ed any answers/questions. I'm not on the mailing list.

Greetings,

Reason for posting/sending this email.

1. the actual message:
pppoe[1857]: Linux select bug hit! This message is harmless, but please
ask the Linux kernel developers to fix it.

I connect to the InterNet via my ADSL provider. From time to time, my
adsl connection dies and following it, i receive a message in my logs
concerning a Linux bug hit.

I'm using N_HDLC line discipline for synchronous mode.
The adsl daemon is provided by the rp-pppoe package. If for any reasons,
anyone on this list wishes to look in further, please contact me, so
that i can provide them with more accurate information.

Currently running: kernel 2.4.17
At this moment i'm using kernel mode pppoe, and i havent seen "linux 
select bug hit" At the time that i wrote this email i was using the 
regular pppoe mode with n_hdlc line discipline.

Al

