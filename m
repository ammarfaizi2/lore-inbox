Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275461AbTHNUtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275464AbTHNUtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:49:10 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28171 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275461AbTHNUtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:49:08 -0400
Date: Thu, 14 Aug 2003 21:49:06 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interlace and doublescan modes support for tdfxfb in
 2.6
In-Reply-To: <20030814201951.GC27236@satan.blackhosts>
Message-ID: <Pine.LNX.4.44.0308142148510.15200-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applying patch. It will be in the next code drop.


On Thu, 14 Aug 2003, Jakub Bogusz wrote:

> Like the second tdfxfb patch I've posted a while ago - it was posted to
> linux-fbdev-devel few days ago, but I haven't got any feedback...
> 
> It works on my Voodoo4 4500 and shouldn't cause any problems on other
> Voodoos - it's just a port of changes between 2.4.20 and 2.4.21.
> 
> 
> ----- Forwarded message from Jakub Bogusz <qboosh at pld-linux.org> -----
> 
> Date: Sun, 10 Aug 2003 01:24:55 +0200
> From: Jakub Bogusz <qboosh at pld-linux.org>
> To: linux-fbdev-devel at lists.sourceforge.net
> Subject: [PATCH] interlace and doublescan modes support for tdfxfb in 2.6
> 
> Hello,
> 
> this patch adds interlace and doublescan modes support to tdfxfb in 2.6
> (it's a port of changes already incorporated into 2.4.21).
> 
> [...]
> 
> 

