Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264829AbSJOVBm>; Tue, 15 Oct 2002 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264826AbSJOVA7>; Tue, 15 Oct 2002 17:00:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263966AbSJOVAD>;
	Tue, 15 Oct 2002 17:00:03 -0400
Date: Tue, 15 Oct 2002 13:58:12 -0700 (PDT)
Message-Id: <20021015.135812.111263418.davem@redhat.com>
To: maxk@qualcomm.com
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rename _bh to _softirq
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20021015135529.051b49b0@mail1.qualcomm.com>
References: <5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com>
	<20021015.131929.103080718.davem@redhat.com>
	<5.1.0.14.2.20021015135529.051b49b0@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
   Date: Tue, 15 Oct 2002 14:02:22 -0700

   I guess we should then have some kinda readme that explains what
   all those things are. And the BH context covers softirqs and tasklets.

That sounds fine.
