Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUL2I6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUL2I6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUL2I6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 03:58:04 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:30149 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261313AbUL2I6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 03:58:00 -0500
Date: Wed, 29 Dec 2004 08:57:59 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: running Linus kernel on FC3
Message-ID: <Pine.LNX.4.58.0412290853540.2899@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to run a linus bk tree on my FC3 system, but I get a lot of
Selinux warnings with minilogd,

Are there some selinux patches that haven't made their way into Linus's
tree but are in the FC kernel?

I don't mind running without Selinux but I like to keep my .config as
close to the FC one as possible..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

