Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVAHEPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVAHEPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 23:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVAHEPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 23:15:30 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:4497 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261780AbVAHEP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 23:15:26 -0500
Date: Sat, 8 Jan 2005 04:15:24 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Cc: jonsmirl@gmail.com
Subject: lindenting the drm directory..
Message-ID: <Pine.LNX.4.58.0501080411190.11556@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the DRM is in a bad way with respect to whitespace, I know people have
objections to whitespace patches in bitkeeper, but after cleaning up all
the code, I'd like to Lindent it all as well, the DRM macro removal
touched every function in every file...

as the DRM is developed in the CVS tree, and nearly all the blame
annotation in bitkeeper blames me I don't think it is really a bad thing
for the DRM...

Objections?
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

