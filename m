Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTJVXJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTJVXJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:09:33 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:11529 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261336AbTJVXJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:09:32 -0400
Date: Thu, 23 Oct 2003 00:09:30 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: VesaFB/OFFb power management.
Message-ID: <Pine.LNX.4.44.0310222359470.25125-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I like to be able to suspend and resume these drivers. I noticed the 
SA1100 driver does this using struct device_driver. Is it possible to do 
this for VesaFB/OFFb ? What would be the bus field then?


