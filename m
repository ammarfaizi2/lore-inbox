Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbRLTGGV>; Thu, 20 Dec 2001 01:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286149AbRLTGDz>; Thu, 20 Dec 2001 01:03:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56195 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286158AbRLTGDL>;
	Thu, 20 Dec 2001 01:03:11 -0500
Date: Wed, 19 Dec 2001 22:02:47 -0800 (PST)
Message-Id: <20011219.220247.101870714.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, cs@zip.com.au, billh@tierra.ucsd.edu,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011220005928.F3682@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112192136300.19214-100000@penguin.transmeta.com>
	<20011219.215730.66180642.davem@redhat.com>
	<20011220005928.F3682@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Thu, 20 Dec 2001 00:59:28 -0500
   
   Show me how to make a single process server that can handle 100000 or more 
   open tcp sockets that doesn't collapse under load.  I can do it with aio; 
   can you do it without?

Why are you limiting me to a single process? :-)  Can I have at least
1 per cpu possibly? :-)))
