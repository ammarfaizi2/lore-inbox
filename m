Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUBJR4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUBJRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:54:45 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:32781 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266140AbUBJRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:51:29 -0500
Date: Tue, 10 Feb 2004 17:51:26 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Newest fbdev patch to go mainline.
In-Reply-To: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0402101750150.6600-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One more thing. What should I use for devices like vesafb? Should I use 
the platform_bus_type like sa1100fb.c?


