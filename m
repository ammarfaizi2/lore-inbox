Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbULQDtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbULQDtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 22:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbULQDq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 22:46:26 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:3261 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262752AbULQDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 22:42:25 -0500
Message-ID: <41C2559C.2010209@f2s.com>
Date: Fri, 17 Dec 2004 03:42:20 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arm26 arch and include updates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. the patch is fairly large, so I've provided a link to it. I'd 
appreciate it if someone could apply the changes in the following:

(the patch is relative to 2.6.10-rc3-bk10)

http://mnementh.co.uk/arm26linux/patches/arm26_2_6_10_archinc_patch.bz2

The changes are all local to arm26 - that is to say include/asm-arm26/ 
and arch/arm26/.

Mostly keep-it-compiling fixes, header updates, and a lot more FIXMEs 
added to highlight problem areas. Some significant code tidyups are 
beginning, and some more arm32 left-overs are removed.

-Spyro

Ian Molton, arm26 maintainer.
