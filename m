Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRI3SxY>; Sun, 30 Sep 2001 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273983AbRI3SxQ>; Sun, 30 Sep 2001 14:53:16 -0400
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:16617 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273977AbRI3SxF>; Sun, 30 Sep 2001 14:53:05 -0400
Message-ID: <3BB769F3.A9273786@home.com>
Date: Sun, 30 Sep 2001 14:52:35 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.10 and ipchains support.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I have been trying to get ipchains support in the 2.4.10 kernel.
I do a make xconfig and it's greyed out.
Has ipchains support been dropped and is this just an artifact??

Iptables support works but some of the modules have undefineds when they
are loaded.
This symbol problem for iptables seems to come and go in 2.4.x kernels.
I complie support into the kernel and everything else as modules.

John


