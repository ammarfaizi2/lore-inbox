Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRC0UeA>; Tue, 27 Mar 2001 15:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRC0Udu>; Tue, 27 Mar 2001 15:33:50 -0500
Received: from scooby-s1.lineone.net ([194.75.152.224]:45287 "EHLO
	scooby.lineone.net") by vger.kernel.org with ESMTP
	id <S131562AbRC0Udo>; Tue, 27 Mar 2001 15:33:44 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19: Bad #include's in drivers/char/toshiba.c 
In-Reply-To: Message from Horst von Brand <vonbrand@inf.utfsm.cl> 
   of "Tue, 27 Mar 2001 14:17:58 EDT." <200103271817.f2RIHwRe014238@tigger.valparaiso.cl> 
In-Reply-To: <200103271817.f2RIHwRe014238@tigger.valparaiso.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Mar 2001 21:32:40 +0100
From: Jonathan Buzzard <jonathan@buzzard.org.uk>
Message-Id: <E14i08u-0001HW-00@happy.buzzard.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



vonbrand@inf.utfsm.cl said:
> The build fails here for lack of "toshiba.h". Changing that to
> <linux/toshiba.h> gets the build through. While at it, I fixed some
> "#include<..." (no ' ' before the '<'), which may be right but look
> ugly IMVHO. 

Apologies to all for that. I have been a bit of a dunderhead. I spotted the
mistake originally while checking the patch. Did the patch again, and promptly
sent the wrong one to Alan.

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan@buzzard.org.uk
Northumberland, United Kingdom.       Tel: +44(0)1661-832195



-- 
Jonathan A. Buzzard                 Email: jonathan@buzzard.org.uk
Northumberland, United Kingdom.       Tel: +44(0)1661-832195


