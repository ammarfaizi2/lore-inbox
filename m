Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTJVRbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTJVRbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 13:31:25 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:33540 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263131AbTJVRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 13:31:25 -0400
Date: Wed, 22 Oct 2003 18:31:22 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FBDEV UPDATE] Newer patch.
Message-ID: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks. 

  I have a new patch against 2.6.0-test8. This patch is a few fixes and I 
added back in functionality for switching the video mode for fbcon via 
fbset again. Give it a try and let me know the results.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz



