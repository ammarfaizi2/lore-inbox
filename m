Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSHHQBO>; Thu, 8 Aug 2002 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSHHQBO>; Thu, 8 Aug 2002 12:01:14 -0400
Received: from ns1.weccusa.org ([207.1.28.170]:4080 "EHLO trabajo")
	by vger.kernel.org with ESMTP id <S317603AbSHHQBO>;
	Thu, 8 Aug 2002 12:01:14 -0400
Date: Thu, 8 Aug 2002 11:04:56 -0500
From: "Bryan K. Walton" <thisisnotmyid@tds.net>
To: linux-kernel@vger.kernel.org
Subject: problems with 1gb ddr memory sticks on linux
Message-ID: <20020808160456.GI16225@weccusa.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box running Debian 3.0 with a Via C3 800mhz processor
that slows to a crawl when I put in a 1GB stick of PC2100 DDR memory.

The board, a Gigabyte GA-6RX, supports this memory stick.
My 2.4.18 kernel is compiled with High Memory support and linux and the
bios see all of the memory.  However, the box is VERY slow.  It takes
about 5 minutes to install .deb binary.  It took me 12 hours to compile
the 2.4.18 kernel!

Here is what I have done to rule things out . . .

1) The box runs FAST with M$ Windows 2000.
2) The box runs FAST when using identical kinds of memory but in
quantities of 512MB or less.
3) The box runs slow with other linux distos also. (I tried Redhat 7.2)

It seems to me that the problem has something to do with the linux
kernel and 1GB memory sticks.  Am I off base?

Anyone have any ideas?

Thanks,
Bryan Walton
