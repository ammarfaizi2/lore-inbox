Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbVKREt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbVKREt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVKREt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:49:57 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:56280 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S1751496AbVKREt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:49:56 -0500
Date: Thu, 17 Nov 2005 21:49:45 -0700
From: Hans Fugal <hans@fugal.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Message-ID: <20051118044945.GA6647@falcon.fugal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Editor: Vim http://vim.sf.net/
X-Info: http://hans.fugal.net/
X-Operating-System: Linux falcon 2.6.13-rt13
User-Agent: Mutt/1.5.9i
Subject: 2.6.14-rt13 panic on boot
X-SA-Exim-Connect-IP: 166.70.27.96
X-SA-Exim-Mail-From: fugalh@falcon.fugal.net
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mgr4.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-rt13 panics on my machine during the boot process. It gets to the
point where it loads my sound card, or just after (it goes by too fast
to tell), and then panics verbosely. You can see the .config, a terrible
movie, and screenshot at:

http://hans.fugal.net/tmp/2.6.14-rt13

-- 
Hans Fugal ; http://hans.fugal.net
 
There's nothing remarkable about it. All one has to do is hit the 
right keys at the right time and the instrument plays itself.
    -- Johann Sebastian Bach
