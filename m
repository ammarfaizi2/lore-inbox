Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbTBGJ2V>; Fri, 7 Feb 2003 04:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBGJ2V>; Fri, 7 Feb 2003 04:28:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1500 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267757AbTBGJ2V>;
	Fri, 7 Feb 2003 04:28:21 -0500
Date: Fri, 07 Feb 2003 01:24:11 -0800 (PST)
Message-Id: <20030207.012411.44088551.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: acc@CS.Stanford.EDU, linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU,
       kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] Re: [CHECKER] 112 potential memory leaks in 2.5.48
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0302052259590.28037-100000@blackbird.intercode.com.au>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
	<Pine.LNX.4.44.0302052259590.28037-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Wed, 5 Feb 2003 23:19:14 +1100 (EST)
   
   Here's a fix for 2.5.59.
   
Applied, and backported to 2.4.x as the bug is there too.
