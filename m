Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271502AbTGQQvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271338AbTGQQvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:51:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:263 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271504AbTGQQvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:51:02 -0400
Date: Thu, 17 Jul 2003 18:05:54 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Amit Shah <shahamit@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Framebuffer problem
In-Reply-To: <200307161107.40159.shahamit@gmx.net>
Message-ID: <Pine.LNX.4.44.0307171804370.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > #
> > # Graphics support
> > #
> > CONFIG_FB=y
> > # CONFIG_FB_CIRRUS is not set
> > # CONFIG_FB_PM2 is not set
> > # CONFIG_FB_CYBER2000 is not set
> > # CONFIG_FB_IMSTT is not set
> > CONFIG_FB_VGA16=y 		<---- to many drivers selected. Please 
				<---- pick only one.
> > CONFIG_FB_VESA=y
> > CONFIG_VIDEO_SELECT=y
> > # CONFIG_FB_HGA is not set
> > CONFIG_FB_RIVA=y		<-----
> > # CONFIG_FB_I810 is not set
> > # CONFIG_FB_MATROX is not set
> > # CONFIG_FB_RADEON is not set
> > # CONFIG_FB_ATY128 is not set
> > # CONFIG_FB_ATY is not set
> > # CONFIG_FB_SIS is not set
> > # CONFIG_FB_NEOMAGIC is not set
> > # CONFIG_FB_3DFX is not set
> > # CONFIG_FB_VOODOO1 is not set
> > # CONFIG_FB_TRIDENT is not set
> > # CONFIG_FB_PM3 is not set
> > # CONFIG_FB_VIRTUAL is not set

