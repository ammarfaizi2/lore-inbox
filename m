Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266111AbSKFVL0>; Wed, 6 Nov 2002 16:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKFVL0>; Wed, 6 Nov 2002 16:11:26 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:46346 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S266111AbSKFVLZ>; Wed, 6 Nov 2002 16:11:25 -0500
Message-ID: <YWxhbg==.b4f88cdf91f892d4cab2b2076d330c27@1036617237.cotse.net>
Date: Wed, 6 Nov 2002 16:13:57 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: [reiserfs-dev] build failure: reiser4progs-0.1.0
From: "Alan Willis" <alan@cotse.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ./configure --enable-Werror=no
Just confirming that this worked for me.  Had some problem with readline,
so I tried disabling it.

./configure --enable-Werror=no --without-readline --disable-readline

This worked for me on RH 8.0 (gcc 3.2-10)
I have reiser4 on an ide partition.  What sorts of tests would be useful?

-alan



