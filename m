Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUK0FRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUK0FRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUK0Dzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:55:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262506AbUKZTd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:26 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 26 Nov 2004 12:39:04 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: caszonyi@rdslink.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol in bttv module in 2.6.10-rc2 (fwd)
Message-ID: <20041126113904.GB10801@bytesex>
References: <Pine.LNX.4.60.0411260053410.559@grinch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0411260053410.559@grinch.ro>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the boot script is inserting the bttv modules on 2.6.10-rc2 the 
> following error occures:
> insmod: error inserting 
> '/lib/modules/2.6.10-rc2/kernel/drivers/media/video/bttv.k
> o': -1 Unknown symbol in module

Use modprobe, not insmod.

  Gerd

