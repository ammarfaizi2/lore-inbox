Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUJINtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUJINtV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUJINtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:49:21 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:37337 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266870AbUJINtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:49:19 -0400
Date: Sat, 9 Oct 2004 14:49:18 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: dri-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org
Subject: [rfc] VIA drm patch and bk tree for inclusion in kernel..
Message-ID: <Pine.LNX.4.58.0410091447170.25574@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
       Okay the VIA DRM people have asked to include it in the kernel, it
only allows accelerated XvMC for non-root users, and 3d for root users
(the 3d paths are still not secure)...

The bk tree at

bk://drm.bkbits.net/drm-via

the patch against Linus latest (along with some cleanup patches...)

is at (it is quite big...)

http://www.skynet.ie/~airlied/patches/dri/via_unichrome_patch.diff

Can VIA people test this tree for me? either use bk or grab Linus latest
and apply the patch...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

