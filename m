Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSLMPGz>; Fri, 13 Dec 2002 10:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSLMPGz>; Fri, 13 Dec 2002 10:06:55 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:33551 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264730AbSLMPGy>;
	Fri, 13 Dec 2002 10:06:54 -0500
Date: Fri, 13 Dec 2002 10:14:43 -0500 (EST)
Message-Id: <200212131514.gBDFEhL268190@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: lostlogic@gentoo.org, acahalan@cs.uml.edu
Subject: Re: procps 2.x vs. procps 3.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brandon Low writes:

> Well at Gentoo, we are kinda using both right now.  We've noticed
> some querkiness with the 3.x series where TOP will miss certain
> characters in output,

If nobody else knows about it, it's not too likely to get fixed.
Send bug reports to procps-feedback@lists.sf.net please.

Before you do: "certain characters" will need some explaining.
(position? value? completely gone or turned into a space?)

> but the 3.x series is much prettier and
> feature rich than the 2.x series.  On the other hand, 2.x is 
> consistently more up to date with kernel changes since RML and Riel
> maintain it and are intimately familiar with current kernel
> development.  

I just got the last bit, /proc/*/wchan usage on 2.5.xx kernels.
Oddly, I'm ahead right now. I have a vmstat that uses a fast O(1)
algorithm on 2.5.xx kernels and reports the IO-wait time. I also
have a sysctl that handles the 2.5.xx VLAN interfaces.

