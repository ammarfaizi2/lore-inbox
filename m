Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUGFCFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUGFCFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 22:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUGFCFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 22:05:33 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:47000 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262547AbUGFCFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 22:05:32 -0400
Date: Tue, 6 Jul 2004 03:05:31 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: kernel image reproducibility...
Message-ID: <Pine.LNX.4.58.0407060257550.17004@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I'm going to do this for myself anyway but I'm wondering if anyone
here has either done this before or knows a nice way to do it..

I've got a system for a regulated market based on a standard 2.6.6 kernel,
now the problem I have is I have to be able to rebuild the exact same
kernel image months or years from now on a different system, now I have my
own toolchain so that isn't a major issue, the problem I have is the
kernel's compile.h file ..

My plan at the moment is probably just to replace the script that creates
that file with a hack to make the file the same always... anyone any nicer
way to do this?

Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

