Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVBAOZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVBAOZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVBAOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:25:07 -0500
Received: from mail.tmr.com ([216.238.38.203]:59654 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262024AbVBAOZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:25:03 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Memory Stick read-only in 2.6.10
Date: Tue, 01 Feb 2005 09:28:45 -0500
Organization: TMR Associates, Inc
Message-ID: <cto2rs$tuu$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1107267260 30686 192.168.12.100 (1 Feb 2005 14:14:20 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded a system from 2.4.19 (or so) to 2.6.10. Using a USB memory 
stick reader one, and only one, stick is now read-only.
  - I can't go back, this was a backup/reinstall upgrade
  - it doesn't happen on Win98
  - it doesn't happen on WinXPhome
  - it doesn't happen on OSX
  - it doesn't happen in the camera
  - it doesn't happen with four other sticks bought at the same time
    and used in the same camera

Out of the box FC2 + 2.6.10 built from kernel.org source.

Before I start playing with the drivers and all, is there a known oddity 
in this area which I missed searching?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
