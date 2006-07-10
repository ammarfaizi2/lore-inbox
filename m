Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965269AbWGJWN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbWGJWN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWGJWN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:13:59 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:12540 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S965270AbWGJWN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:13:58 -0400
Message-ID: <44B2D122.6010005@lwfinger.net>
Date: Mon, 10 Jul 2006 17:13:54 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: John Linville <linville@tuxdriver.com>, linux-kernel@vger.kernel.org
Subject: Error in git pull
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

I just pulled your latest changes from the wireless-2.6 repository. When I did so, I got the 
following git error:

finger@larrylap:~/wireless-2.6> git pull
Unpacking 22599 objects
  100% (22599/22599) done
error: no such remote ref refs/heads/zd1211rw
* refs/heads/origin: does not fast forward to branch 'master' of 
git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6;
   not updating.

Is there any way for me to recover without pulling the entire tree again?

Thanks,

Larry
