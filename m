Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVDCTQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVDCTQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVDCTQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:16:59 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:30748 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261880AbVDCTQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:16:04 -0400
Date: Sun, 3 Apr 2005 21:17:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Auto-append localversion for BK users needs to use CONFIG_SHELL
Message-ID: <20050403191720.GH9014@mars.ravnborg.org>
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org> <20050310054011.GA8287@mars.ravnborg.org> <20050313043229.GA7828@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313043229.GA7828@mythryan2.michonline.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 11:32:29PM -0500, Ryan Anderson wrote:
> 
> Sam, you'll probably want this on top of the patch I sent.  (I haven't
> built in a clean tree in a while, found a minor problem when I was
> transitioning to quilt today.)

Combined this to one patch and applied it.
Let's see what feedback lkml gives.

	Sam
