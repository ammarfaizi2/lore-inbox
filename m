Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314239AbSD2SJN>; Mon, 29 Apr 2002 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314360AbSD2SJM>; Mon, 29 Apr 2002 14:09:12 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:9005 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S314239AbSD2SJL>; Mon, 29 Apr 2002 14:09:11 -0400
Date: Mon, 29 Apr 2002 19:16:30 +0100
From: Ian Molton <spyro@armlinux.org>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: kala@pinerecords.com, alchemy@us.ibm.com, rml@tech9.net,
        alan@lxorguk.ukuu.org.uk, rthrapp@sbcglobal.net,
        linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Message-Id: <20020429191630.6ba84c33.spyro@armlinux.org>
In-Reply-To: <Pine.GSO.4.05.10204291939240.21793-100000@mausmaki.cosy.sbg.ac.at>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.5cvs1 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas 'Dent' Mirlacher Awoke this dragon, who will now respond:

>  > Warning: Module %s is not open source, and as such, loading it will
>  > make your kernel un-debuggable. Please do not submit bug reports from
>  > a kernel with this module loaded, as they will be useless, and likely
>  > ignored.
> 
>  well, that's not the truth: the kernel itself is debuggable, but we
>  don't know about the module, and how the module interacts with the
>  kernel.

It absolutely IS the truth.

what happens if an errant module clobbers kernel space?
