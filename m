Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280641AbRKJNcT>; Sat, 10 Nov 2001 08:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280637AbRKJNcC>; Sat, 10 Nov 2001 08:32:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8064 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280638AbRKJNbt>;
	Sat, 10 Nov 2001 08:31:49 -0500
Date: Sat, 10 Nov 2001 05:31:42 -0800 (PST)
Message-Id: <20011110.053142.63130496.davem@redhat.com>
To: sven.vermeulen@rug.ac.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011110132139.A872@Zenith.starcenter>
In-Reply-To: <20011110132139.A872@Zenith.starcenter>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
   Date: Sat, 10 Nov 2001 13:21:39 +0100
   
   I'm not using OpenSSH 3.0 yet (2.9p2). I'm not running any firewall or
   transparent proxying.

You will only see the bug if you are using netfilter.

Franks a lot,
David S. Miller
davem@redhat.com
