Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTELVcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTELVcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:32:07 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:59665 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262720AbTELVcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:32:06 -0400
Date: Mon, 12 May 2003 22:44:29 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Vesa fix
Message-ID: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
  
   The results of the EDID info from the BIOS has been varied. For some it 
worked. Others it gave the wrong data. Then for other even the headers 
where corrupted :-( So this patch pulls out the EDID code from Vesa. The 
EDID code works for PPC tho :-)


