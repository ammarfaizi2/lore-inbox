Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbUDQFYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUDQFYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:24:24 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:30849
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263648AbUDQFYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:24:23 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5FF89D68-8FD9-11D8-988A-000A958E35DC@fhm.edu>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <20040416144433.GE2253@logos.cnet>  <408001E6.7020001@treblig.org>
	 <1082132015.2581.30.camel@lade.trondhjem.org>
	 <5FF89D68-8FD9-11D8-988A-000A958E35DC@fhm.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082179464.3012.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 22:24:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 12:07, Daniel Egger wrote:

> Great you want to help here. So I've a system which is NFS root using a
> 3c940 gigabit onboard NIC on kernel 2.6.5 and which is dead fish in the
> water somewhere in between 10 seconds and 5 minutes after boot using
> NFS over UDP. The last thing I see are 3 or 4 messages of the type:

...and if you use TCP?

> server 192.168.11.2 not responding, still trying

The other thing I'd need is a tcpdump. Something like "tcpdump -s 9000
-w dump.out"...

Cheers,
  Trond
