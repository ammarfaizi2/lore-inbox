Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281796AbRKVWD5>; Thu, 22 Nov 2001 17:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbRKVWDr>; Thu, 22 Nov 2001 17:03:47 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:23955 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281796AbRKVWDl>;
	Thu, 22 Nov 2001 17:03:41 -0500
Message-ID: <3BFD7633.2525641E@pobox.com>
Date: Thu, 22 Nov 2001 14:03:31 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre8-tux i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: sunrpc woes with tux2 in 2.4.15-pre8,9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In 2.4.15-pre8 I applied the tux2 patches to
take it for a spin - well, it's insanely fast, thanks
Ingo - but I am having a problem with the sun
rpc module:

depmod gives the following result on -pre8
and -pre9:

depmod: *** Unresolved symbols in
/lib/modules/2.4.15-pre9/kernel/net/sunrpc/sunrpc.o
depmod:         atomic_dec_and_lock_R648ef859

Just a heads-up -

cu

jjs



