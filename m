Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTATU1m>; Mon, 20 Jan 2003 15:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTATU1m>; Mon, 20 Jan 2003 15:27:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266969AbTATU1l>;
	Mon, 20 Jan 2003 15:27:41 -0500
Message-Id: <200301202036.h0KKaJ011167@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: folkert@vanheusden.com
cc: linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: tool for testing how fast your kernel can rename files :-) 
In-Reply-To: Message from <folkert@vanheusden.com> 
   of "Mon, 20 Jan 2003 18:29:25 +0100." <Pine.LNX.4.33.0301201826120.13207-100000@muur.intranet.vanheusden.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jan 2003 12:36:19 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> This night, while half a-sleep I thought it is usefull to have a tool
> which creates a number of files in a directory and then starts to randomly
> rename them. During this, it should output how much it has done and how
> many renames per second it did.
> 5 minutes back I programmed such a program, you can download it from:
> http://www.vanheusden.com/Linux/rename_test-1.0.tgz
> 
> But now, fully awake with at least 8 cups of coffee in my system I cannot
> think of anything usefull this program is actually doing.
> Well, maybe to test if something gets corrupted allong the way?
> 
> Oh well.

Here's a suggestion: 
Take one Very Old Kernel (say, 2.4.2) 
and one Very New Kernel (2.5.59 ??) 
Run your test on both, and see what differences you see. 
If you see a change greater than 10%, that's a sign your test is 
useful...or not.
cliffw

> 
> 
> Folkert van Heusden
> www.vanheusden.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


