Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279580AbRKIHOk>; Fri, 9 Nov 2001 02:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRKIHOa>; Fri, 9 Nov 2001 02:14:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8322 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279580AbRKIHOU>;
	Fri, 9 Nov 2001 02:14:20 -0500
Date: Thu, 08 Nov 2001 23:14:05 -0800 (PST)
Message-Id: <20011108.231405.59654385.davem@redhat.com>
To: ak@suse.de
Cc: anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011109073946.A19373@wotan.suse.de>
In-Reply-To: <20011109064540.A13498@wotan.suse.de>
	<20011108.220444.95062095.davem@redhat.com>
	<20011109073946.A19373@wotan.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 9 Nov 2001 07:39:46 +0100
   
   Before jumping to real conclusions it would be interesting to gather
   some statistics on Anton's machine, but I suspect he just has an very
   unevenly populated table.
   
N_PAGES / N_HASHCHAINS was on the order of 9, and the hash chains were
evenly distributed.  He posted URLs to graphs of the hash table chain
lengths.

Franks a lot,
David S. Miller
davem@redhat.com

   
