Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUKMVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUKMVVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUKMVTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:19:01 -0500
Received: from sd291.sivit.org ([194.146.225.122]:17885 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261176AbUKMVSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:18:21 -0500
Date: Sat, 13 Nov 2004 22:18:16 +0100
From: Luc Saillard <luc@saillard.org>
To: Gergely Nagy <algernon@bonehunter.rulez.org>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
Subject: Re: pwc driver status?
Message-ID: <20041113211816.GC22949@sd291.sivit.org>
References: <200411132134.52872.lkml@kcore.org> <1100378556.16772.18.camel@melkor> <200411132203.32908.lkml@kcore.org> <1100380178.16772.23.camel@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100380178.16772.23.camel@melkor>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 10:09:38PM +0100, Gergely Nagy wrote:
> > Unfortunately, upgrading is not an option right now for other reasons...
> 
> That's a pity... because there is no 2.4 version of Luc's driver as far
> as I know :(

I don't use a 2.4 kernel, so i can produce patch for older kernel, but i'll
not test them. If someone want a 2.4 kernel tell me, and i'll try to mande a
patch using difftools. I prefer to add features like v4l2, than supporting
and testing old kernel (or writing documentation).

> > Is this driver also supporting the Logitech Quickcam for Notebooks? I found 
> > some references that the 'official' one used to do that, but I can't find 
> > much docs... 
> 
> As far as I know, yes. The source code seems to indicate the same.

If the old driver supports, mine too (minor some very old webcam).

Luc
