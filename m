Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVCTTeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVCTTeG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVCTTeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:34:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:11985 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261252AbVCTTcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:32:41 -0500
Date: Sun, 20 Mar 2005 20:34:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][trivial] matroxfb_maven remove pointless semicolons
 after label
In-Reply-To: <20050320191728.GF32717@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0503202033000.2508@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503201737250.2501@dragon.hyggekrogen.localhost>
 <20050320191728.GF32717@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Petr Vandrovec wrote:

> On Sun, Mar 20, 2005 at 05:41:01PM +0100, Jesper Juhl wrote:
> > 
> > Having a semicolon at the end as in  labelname:;  is pointless, remove.
> 
> As long as I'm maintainer of this code, I prefer to leave them here.
> 							Petr Vandrovec
> 
No problem. As you say, you're the maintainer. I just spotted them and 
made the patch, it's ofcourse entirely up to you if you want to apply it 
or not :-)

-- 
Jesper Juhl


