Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280656AbRKJNqt>; Sat, 10 Nov 2001 08:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280658AbRKJNqj>; Sat, 10 Nov 2001 08:46:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16768 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280656AbRKJNqV>;
	Sat, 10 Nov 2001 08:46:21 -0500
Date: Sat, 10 Nov 2001 05:44:45 -0800 (PST)
Message-Id: <20011110.054445.79069608.davem@redhat.com>
To: anton@samba.org
Cc: ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011110.052917.41199152.davem@redhat.com>
In-Reply-To: <20011109073946.A19373@wotan.suse.de>
	<20011110155603.B767@krispykreme>
	<20011110.052917.41199152.davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Sat, 10 Nov 2001 05:29:17 -0800 (PST)

   Anton, are you bored?  :-) If so, could you test out the patch
   below on your ppc64 box?  It does the "page hash table via bootmem"
   thing.  It is against 2.4.15-pre2

Erm, ignore this patch, it was incomplete, I'll diff it up
properly.  Sorry...

Franks a lot,
David S. Miller
davem@redhat.com
