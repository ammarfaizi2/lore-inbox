Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUIKBCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUIKBCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 21:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUIKBCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 21:02:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:61397 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268010AbUIKBCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 21:02:17 -0400
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@pol.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200409110504.09812.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston>
	 <200409110504.09812.adaplas@hotpop.com>
Content-Type: text/plain
Message-Id: <1094864419.2578.154.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 11:00:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 07:04, Antonino A. Daplas wrote:
> Hi Ben,
> 
> How about this patch?  This brings back the old way of setting up the
> drivers, supports:
> 
> video=xxxfb:off
> video=ofonly
> 
> Your patch that brings offb to the very last of the Makefile is needed.

Looks good !

Ben.


