Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSJNT1k>; Mon, 14 Oct 2002 15:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262134AbSJNT1j>; Mon, 14 Oct 2002 15:27:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38300 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262126AbSJNT1g>;
	Mon, 14 Oct 2002 15:27:36 -0400
Date: Mon, 14 Oct 2002 12:26:28 -0700 (PDT)
Message-Id: <20021014.122628.63756731.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org, rusty@rustcorp.com.au
Subject: Re: [RFC] bridge-nf -- map IPv4 hooks onto bridge hooks, vs 2.5.42
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210142129.56824.bart.de.schuymer@pandora.be>
References: <200210142058.53355.bart.de.schuymer@pandora.be>
	<20021014.120200.77420883.davem@redhat.com>
	<200210142129.56824.bart.de.schuymer@pandora.be>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Mon, 14 Oct 2002 21:29:56 +0200

   You were the one who asked for that patch.
   
I asked for the patch to be cleaned up to eliminate
the net/ipv4/*.c hacking. :)

   This brings me to another question: I've been told it is the
   general concensus  that this bridge firewall should be compiled in
   the kernel if CONFIG_NETFILTER=y.

I don't have any strong opinion here.
