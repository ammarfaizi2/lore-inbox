Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTDVSvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTDVSvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:51:24 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2747 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263359AbTDVSvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:51:21 -0400
Date: Tue, 22 Apr 2003 21:03:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org, Simon Evans <spse@secret.org.uk>,
       Abraham vd Merwe <abraham@2d3d.co.za>, mtd@infradead.org,
       Linus Torvalds <torvalds@transmeta.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] C99 initializers for drivers/mtd/devices
Message-ID: <20030422190324.GC12947@wohnheim.fh-wedel.de>
References: <20030422155653.GB7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030422155653.GB7260@debian>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 April 2003 10:56:53 -0500, Art Haas wrote:
> 
> Here are two trivial patches adding C99 initializers to the files. The
> patches are against the current BK.

IIRC, you sent four patches for mtd some time ago, but only two of
those applied cleanly to the infradead cvs. The following thread ended
quickly.

Anyway, David, Art, maybe you should discuss this one.

David, do you want to have patches against cvs and feed them to Linus
the next round? Or would you prefer to pull the changes from Linus, so
this should be applied as is?

Art, would you be willing to provide a patch against mtd cvs, in case
David prefers that one? Use either cvs:
cvs -d :pserver:anoncvs@cvs.infradead.org:/home/cvs login (password: anoncvs)
cvs -d :pserver:anoncvs@cvs.infradead.org:/home/cvs co mtd
or the dayly ftp snapshot:
ftp://ftp.uk.linux.org/pub/people/dwmw2/mtd/cvs/
    

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
