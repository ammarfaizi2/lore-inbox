Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbTCGUH1>; Fri, 7 Mar 2003 15:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbTCGUH0>; Fri, 7 Mar 2003 15:07:26 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:56300 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261740AbTCGUHZ>; Fri, 7 Mar 2003 15:07:25 -0500
Subject: Re: [Perfctr-devel] perfctr and Linus' tree?
From: Albert Cahalan <albert@users.sf.net>
To: mikpe@user.it.uu.se
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Mar 2003 15:14:15 -0500
Message-Id: <1047068056.2012.72.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:

> I'm planning to simplify the kernel <--> user-space
> interface in perfctr-2.6 (drop /proc/pid/perfctr and
> go back to /dev/perfctr), and then I _think_ I can
> do a version that doesn't require patching kernel
> source. (It will do binary code patching at module
> load-time instead. Horrible as that sounds, it's
> easier to deal with for users.)

That would make porting more difficult. I don't think
these changes will help you gain acceptance.



