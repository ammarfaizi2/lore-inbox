Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSKNF47>; Thu, 14 Nov 2002 00:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSKNF46>; Thu, 14 Nov 2002 00:56:58 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:63964 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264767AbSKNF45>; Thu, 14 Nov 2002 00:56:57 -0500
Message-ID: <3DD34E39.67FCB16F@earthlink.net>
Date: Wed, 13 Nov 2002 23:18:17 -0800
From: alfredo & iole <alfiole@earthlink.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel: eth0: Transmit error, Tx status register 90, kernel 2.4.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed 2.4.19 and I got 

kernel: eth0: Transmit error, Tx status register 90

I red some e-mail about this problem and I realize that it was a issue
in the old version of the 3c59x driver (1999).
I think it was fix in 2.4.14 and it is back in 2.4.19.
I saw a revert patch in che changelog of 2.4.19 ....................

Has anybody notice this problem ?

( I am not in the mailing list please reply to my e-mail )

Thanks
Alfredo
