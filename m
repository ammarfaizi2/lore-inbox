Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277085AbRJHTOS>; Mon, 8 Oct 2001 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277084AbRJHTOJ>; Mon, 8 Oct 2001 15:14:09 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:15364 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S277085AbRJHTNx>;
	Mon, 8 Oct 2001 15:13:53 -0400
Date: Mon, 8 Oct 2001 14:01:36 +0200 (CEST)
From: raid@ddx.a2000.nu
To: linux-raid@vger.kernel.org
Subject: write/read cache raid5
Message-ID: <Pine.LNX.4.40.0110081357430.24968-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With current memory prices i think about buying 2gb memory for my
fileserver (6*80gb raid5 ide)
Now i would like to use this memory for diskcache (write cache?)
Are there any things i can change to the kernel/samba to speedup things ?

filesystem is shared using nfs and samba (using a gigabit card)


