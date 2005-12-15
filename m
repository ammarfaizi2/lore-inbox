Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVLOBFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVLOBFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVLOBFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:05:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965145AbVLOBFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:05:45 -0500
Date: Thu, 15 Dec 2005 02:05:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       kkojima@rr.iij4u.or.jp
Cc: linuxsh-dev@lists.sourceforge.net
Subject: [2.6 patch] MAINTAINERS: sh: update the mailing list
Message-ID: <20051215010546.GM23349@stusta.de>
References: <20051212231113.GP23349@stusta.de> <20051213032826.GA16720@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213032826.GA16720@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 05:28:26AM +0200, Paul Mundt wrote:
>...
> If anything, this should be changed to linuxsh-dev@lists.sourceforge.net,
> since that's been the defacto standard list for quite a long time now,

Updated patch below.

> and is what I thought was in there now, in addition to the m17n.org list
> as a fallback. Should I assume that this was also removed by a similar
> "constructive" change?

As far as I can see, linuxsh-dev@lists.sourceforge.net was added in 
kernel 2.4 but never in kernel 2.5/2.6 .

cu
Adrian


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-full/MAINTAINERS.old	2005-12-13 00:09:01.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/MAINTAINERS	2005-12-15 01:57:21.000000000 +0100
@@ -2506,11 +2506,11 @@
 SUPERH (sh)
 P:	Paul Mundt
 M:	lethal@linux-sh.org
 P:	Kazumoto Kojima
 M:	kkojima@rr.iij4u.or.jp
-L:	linux-sh@m17n.org
+L:	linuxsh-dev@lists.sourceforge.net
 W:	http://www.linux-sh.org
 W:	http://www.m17n.org/linux-sh/
 W:	http://www.rr.iij4u.or.jp/~kkojima/linux-sh4.html
 S:	Maintained
 

