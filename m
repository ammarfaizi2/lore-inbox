Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSGTXwY>; Sat, 20 Jul 2002 19:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSGTXwY>; Sat, 20 Jul 2002 19:52:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:53234 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317587AbSGTXwX>; Sat, 20 Jul 2002 19:52:23 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, akpm@zip.com.au,
       Linus Torvalds <torvalds@transmeta.com>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
In-Reply-To: <1027213161.16818.65.camel@irongate.swansea.linux.org.uk>
References: <1027196403.1086.751.camel@sinai> 
	<1027211556.17234.55.camel@irongate.swansea.linux.org.uk> 
	<1027207835.1116.861.camel@sinai> 
	<1027213161.16818.65.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 02:07:06 +0100
Message-Id: <1027213626.16819.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 01:59, Alan Cox wrote:
> > I sent you an email and told you I was doing this and asked your opinion
> > on a percentage.  Why are you picking on me now?
> 
> When did you send me mail - I certainly never saw it. 

Ok I take that back. It merely never got as far into my brain as to stay
stuck. 

Lets go with a sysctl tuned value and see what the 2.5 world finds the
best numbers to be ?

