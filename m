Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274695AbRIYXMT>; Tue, 25 Sep 2001 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274703AbRIYXLU>; Tue, 25 Sep 2001 19:11:20 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:59441 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S274695AbRIYXLJ> convert rfc822-to-8bit; Tue, 25 Sep 2001 19:11:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: __alloc_pages: 0-order allocation failed
Date: Wed, 26 Sep 2001 01:10:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <E15m0Wz-0002He-00@mrvdom01.schlund.de> <20010926010149.U8350@athlon.random>
In-Reply-To: <20010926010149.U8350@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15m1MU-0008OQ-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you enable CONFIG_DEBUG_GFP (kernel debugging menu) in 2.4.10aa1
> and send me full traces of the faliures so I can better see where the
> problem cames from? Thanks!
>
> Andrea

Is it enough, to take a vanilla 2.4.10 and apply 00_debug-gfp-1 and 
00_vm-tweaks-1 or should I patch to a complete aa1. If yes, where can I find 
the complete aa1-Patch in one part?

greetings

Christian
