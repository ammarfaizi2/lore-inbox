Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271228AbTHCSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271230AbTHCSB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:01:28 -0400
Received: from dm4-166.slc.aros.net ([66.219.220.166]:61635 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S271228AbTHCSB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:01:27 -0400
Message-ID: <3F2D4DF4.3030901@aros.net>
Date: Sun, 03 Aug 2003 12:01:24 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2 froze while installing j2sdk-1.4.2 with netbeans (low
 on details)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ran into a system lock up while running 2.6.0-test2 kernel and 
j2sdk-1.4.2-nb-3.5-bin-linux.bin (the latest Sun Java standard kit 
installer with netbeans and run as root). I'm sorry I don't have real 
details. I'm not at liberty to retry the java installer right now. But 
basically the system froze - no mouse movement, no caps-lock light 
toggling, no ctrl-alt-backspace (to shutdown X), no ctrl-alt-delete (to 
reboot), no ctrl-alt-fX (to switch to another console). If someone else 
encounters this then maybe at least the info can be used to better 
identify a pattern (like when this first started showing up).

