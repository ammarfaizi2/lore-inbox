Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUHPF45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUHPF45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUHPF45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:56:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:36255 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267445AbUHPF44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:56:56 -0400
Date: Mon, 16 Aug 2004 06:56:29 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: dri-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org
Subject: DRM and 2.4 ...
Message-ID: <Pine.LNX.4.58.0408160652350.9944@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the moment we are adding a lot of 2.6 stuff to the DRM under
development in the DRM CVS tree and what will be merged into the -mm and
Linus trees eventually, this has meant ifdefing stuff out so 2.4 will
still work,

At some point we are going to make a change that will break 2.4, and I
won't be able to patch it up nicely...

So the question is do we want to a final stable DRM for 2.4 in the next
2.4 release? and after that point I can tag the 2.4 release in the DRM CVS
tree (and maybe branch it ...),

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

