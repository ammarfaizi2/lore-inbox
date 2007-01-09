Return-Path: <linux-kernel-owner+w=401wt.eu-S1751144AbXAIHjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbXAIHjy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXAIHjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:39:54 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58081
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751144AbXAIHjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:39:54 -0500
Date: Mon, 08 Jan 2007 23:39:54 -0800 (PST)
Message-Id: <20070108.233954.84364479.davem@davemloft.net>
To: torvalds@osdl.org
Cc: petero2@telia.com, kaber@trash.net, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: Linux 2.6.20-rc4
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0701081511340.3661@woody.osdl.org>
References: <45A2C6AE.5080400@trash.net>
	<m3ps9pp1fd.fsf@telia.com>
	<Pine.LNX.4.64.0701081511340.3661@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 8 Jan 2007 15:12:08 -0800 (PST)

> 
> 
> On Mon, 9 Jan 2007, Peter Osterlund wrote:
> > 
> > Thanks, the patch appears to help. The kernel has now survived much
> > longer with this patch than it used to do without it.
> > 
> > I will recompile with gcc 4.1.1 too just to make sure, but if you
> > don't hear anything more from me, consider the case closed. :)
> 
> David - I assume I'll get this patch through you, and I can just forget 
> about this issue and go about my normal mindless ways?

Yep, I'll push it to you very soon.

Thanks Patrick for figuring this bug out, nice work.
