Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSLNAhf>; Fri, 13 Dec 2002 19:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbSLNAhf>; Fri, 13 Dec 2002 19:37:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:9098 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265759AbSLNAhf>;
	Fri, 13 Dec 2002 19:37:35 -0500
Date: Sat, 14 Dec 2002 00:45:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: premature closing of bugs in bugzilla.
Message-ID: <20021214004511.GB17008@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
 Just because there's a resolution to a problem in bugzilla does
not mean you should close the bug you reported.  Wait until the
fix is accepted in Linus' tree before doing this, otherwise we
risk people forgetting to push bits.

http://bugzilla.kernel.org/show_bug.cgi?id=162
http://bugzilla.kernel.org/show_bug.cgi?id=163

Are two that I reopened, there may be others, I've
not yet looked..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
