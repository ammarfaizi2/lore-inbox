Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbSKQVx3>; Sun, 17 Nov 2002 16:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbSKQVx3>; Sun, 17 Nov 2002 16:53:29 -0500
Received: from c3po.skynet.be ([195.238.3.237]:60197 "EHLO c3po.skynet.be")
	by vger.kernel.org with ESMTP id <S267617AbSKQVx2>;
	Sun, 17 Nov 2002 16:53:28 -0500
Subject: Re: APIC problem on 2.5.47 SMP noapic
From: Pedro Mullor <mullor@belgacom.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211171617560.19447-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0211171617560.19447-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Nov 2002 23:00:18 +0100
Message-Id: <1037570418.1953.6.camel@nova3>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well... it doesn't change anything apparently, for everytime I change it
before running "make dep" or "make bzImage" it ends changing the
parameters back to "y".

I even tried to change CONFIG_X86_GOOD_APIC to y but it was changed too.

Pedro

On Sun, 2002-11-17 at 22:19, Mark Hahn wrote:
    > CONFIG_X86_LOCAL_APIC=y
    > CONFIG_X86_IO_APIC=y
    
    what happens if you turn those off?
    
    
    
    

