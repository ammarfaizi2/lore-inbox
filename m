Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTBGJ3x>; Fri, 7 Feb 2003 04:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267767AbTBGJ3x>; Fri, 7 Feb 2003 04:29:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4060 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267761AbTBGJ3v>;
	Fri, 7 Feb 2003 04:29:51 -0500
Date: Fri, 07 Feb 2003 01:25:52 -0800 (PST)
Message-Id: <20030207.012552.131114176.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: acc@CS.Stanford.EDU, linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU,
       kuznet@ms2.inr.ac.ru
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0302052302160.28037-100000@blackbird.intercode.com.au>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
	<Pine.LNX.4.44.0302052302160.28037-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Wed, 5 Feb 2003 23:20:08 +1100 (EST)
   
   Here's the ipv6 fix.

Applied, and like the ipv4 fix I also backported it to 2.4.x
