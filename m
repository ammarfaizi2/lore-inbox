Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWAWM17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWAWM17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAWM17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:27:59 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:30997 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1751343AbWAWM16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:27:58 -0500
Date: Sat, 21 Jan 2006 11:41:56 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Michael Loftis <mloftis@wgops.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060121114156.GB3456@linux-mips.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 08:17:40AM -0700, Michael Loftis wrote:

> 
> OK, I don't know abotu others, but I'm starting to get sick of this 
> unstable stable kernel.  Either change the statements allover that were 
> made that even-numbered kernels were going to be stable or open 2.7. 
> Removing devfs has profound effects on userland.  It's one thing to screw 
> with all of the embedded developers, nearly all kernel module developers, 
> etc, by changing internal APIs but this is completely out of hand.

Like devfs or not - but the elemination of devfs was announced ages ago
and anybody reading this list knew it for even much longer.  So this
example just serves to show that for some users no grace time is long
enough.

  Ralf
