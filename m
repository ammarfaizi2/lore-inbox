Return-Path: <linux-kernel-owner+w=401wt.eu-S1161210AbXAHXMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbXAHXMc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbXAHXMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:12:32 -0500
Received: from smtp.osdl.org ([65.172.181.24]:52462 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161210AbXAHXMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:12:31 -0500
Date: Mon, 8 Jan 2007 15:12:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Osterlund <petero2@telia.com>
cc: Patrick McHardy <kaber@trash.net>, "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Linux 2.6.20-rc4
In-Reply-To: <m3ps9pp1fd.fsf@telia.com>
Message-ID: <Pine.LNX.4.64.0701081511340.3661@woody.osdl.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <m37ivyr1v6.fsf@telia.com>
 <Pine.LNX.4.64.0701071442580.3661@woody.osdl.org> <45A2C6AE.5080400@trash.net>
 <m3ps9pp1fd.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2007, Peter Osterlund wrote:
> 
> Thanks, the patch appears to help. The kernel has now survived much
> longer with this patch than it used to do without it.
> 
> I will recompile with gcc 4.1.1 too just to make sure, but if you
> don't hear anything more from me, consider the case closed. :)

David - I assume I'll get this patch through you, and I can just forget 
about this issue and go about my normal mindless ways?

		Linus
