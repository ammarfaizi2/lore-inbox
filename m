Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSKRXC0>; Mon, 18 Nov 2002 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSKRXCZ>; Mon, 18 Nov 2002 18:02:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49025 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264940AbSKRXAy>;
	Mon, 18 Nov 2002 18:00:54 -0500
Date: Mon, 18 Nov 2002 15:05:18 -0800 (PST)
Message-Id: <20021118.150518.63149728.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.48 Compilation Failure skbuff.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0211190013030.22010-100000@blackbird.intercode.com.au>
References: <20021118125450.GA14855@outpost.ds9a.nl>
	<Mutt.LNX.4.44.0211190013030.22010-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Tue, 19 Nov 2002 00:14:10 +1100 (EST)

   On Mon, 18 Nov 2002, bert hubert wrote:
   
   > On Mon, Nov 18, 2002 at 01:36:48PM +0100, Rene Blokland wrote:
   > > Hello, 2.5.48 Doesn't compile for me on a AMD k6-3 with gcc-3.2 and glibc-2.3.1
   > 
   > I bet this just made ipsec mandatory :-)
   
   Not quite yet :-)
   
   A fix is below.

Applied, I'll push this around shortly.
