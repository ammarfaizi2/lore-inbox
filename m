Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVBBUJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVBBUJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVBBT7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:59:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5636 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262779AbVBBTwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:52:36 -0500
Date: Wed, 2 Feb 2005 20:52:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] update Computone MAINTAINERS entry
Message-ID: <20050202195234.GI3313@stusta.de>
References: <20041120002559.GB2754@stusta.de> <20041119194735.63d2a257.akpm@osdl.org> <20041220191530.GA25986@alcove.wittsend.com> <20050101172832.GB14319@stusta.de> <20050118015604.GB31238@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118015604.GB31238@alcove.wittsend.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 08:56:04PM -0500, Michael H. Warfield wrote:
> On Sat, Jan 01, 2005 at 06:28:32PM +0100, Adrian Bunk wrote:
>...
> > It seems you are still active :-) , so why is it "Orphaned"?
> 
> 	Good question.  Probably someone jumping the gun a bit because
> I haven't been very active on that driver lately.  I do tend to drop
> off the radar for months at a time, depending on other projects and
> engagements.  I haven't done updates to the driver in the 2.6 kernel
> and, yes, it is broken.
>...

What about the patch below?

cu
Adrian


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/MAINTAINERS.old	2005-02-02 18:51:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/MAINTAINERS	2005-02-02 18:52:13.000000000 +0100
@@ -561,10 +561,9 @@
 
 COMPUTONE INTELLIPORT MULTIPORT CARD
 P:	Michael H. Warfield
-M:	Michael H. Warfield <mhw@wittsend.com>
+M:	mhw@wittsend.com
 W:	http://www.wittsend.com/computone.html
-L:	linux-computone@lazuli.wittsend.com
-S:	Orphaned
+S:	Maintained
 
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak

