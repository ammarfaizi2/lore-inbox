Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSA3Hzn>; Wed, 30 Jan 2002 02:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288850AbSA3HyG>; Wed, 30 Jan 2002 02:54:06 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:21420 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288814AbSA3Hxy>; Wed, 30 Jan 2002 02:53:54 -0500
Message-Id: <200201291638.g0TGcohv001323@tigger.cs.uni-dortmund.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Mon, 28 Jan 2002 21:06:52 +0100." <E16VI3J-0000C4-00@starship.berlin> 
Date: Tue, 29 Jan 2002 17:38:50 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:

[...]

> Do you know where to find documentation for the assembly instructions 
> themselves?

Standard ia32 references, i.e., at Intel's website. Beware, it is some 500
pages PDF. But they (and standard PC assembly books) use the nearly
unreadable Intel syntax with operands the other way around, so this is much
less of a help than it could be.

Has anyone gotten a instruction listing (just instructions and short
description, not the whole other stuff in there), preferably in AT&T
syntax?
-- 
Horst von Brand			     http://counter.li.org # 22616
