Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVBLAJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVBLAJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVBLAJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:09:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262306AbVBLAJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:09:36 -0500
Date: Sat, 12 Feb 2005 00:09:24 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: What is Badness in map_area_pte at mm/vmalloc.c:126
Message-ID: <Pine.LNX.4.56.0502120008230.18234@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm testing some code and I compiled the Virtual framebuffer as a module.
When I insert it I get a Badness in map_area_pte at mm/vmalloc.c:126. What 
causes this?

