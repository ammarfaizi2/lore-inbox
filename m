Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSI2RfT>; Sun, 29 Sep 2002 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbSI2RfT>; Sun, 29 Sep 2002 13:35:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49671 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261362AbSI2RfT>; Sun, 29 Sep 2002 13:35:19 -0400
Date: Sun, 29 Sep 2002 10:42:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: james <jdickens@ameritech.net>
cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <200209290114.15994.jdickens@ameritech.net>
Message-ID: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Sep 2002, james wrote:
>
> How many people are sitting on the sidelines waiting for guarantee that ide is 
> not going to blow up on our filesystems and take our data with it. Guarantee 
> that ide is working and not dangerous to our data, then I bet a lot more 
> people will come back and bang on 2.5. 

How the hell can I _guarantee_ anything like that?

I can say that the IDE code is the same code that is in 2.4.x, so if 
you're comfortable with 2.4.x wrt IDE, then you should be comfy with 
2.5.x too.

		Linus

