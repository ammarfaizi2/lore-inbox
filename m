Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVCIVQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVCIVQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVCIVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:16:47 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:28075 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S261622AbVCIVMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:12:49 -0500
Date: Wed, 09 Mar 2005 15:12:38 -0600
From: DHollenbeck <dick@softplc.com>
Subject: 2.6.x.y gatekeeper discipline
To: linux-kernel@vger.kernel.org
Message-id: <422F66C6.50208@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had hoped that the proper discipline in rejecting non-critical patches 
would have pertained.  I remain unconvinced that the .y releases are 
anything but noise that should have been kept elsewhere.  After reading 
through a patch summary, I see this as typical:


----------------------


      ChangeSet 2005/02/22 20:56:28-05:00, bunk @ stusta.de
      <http://kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-bunk@stusta.de%5Bjgarzik%5D%7CChangeSet%7C20050223015628%7C49266.txt>
      [diffview]
      <http://www.kernel.org/diff/diffview.cgi?file=/pub/linux/kernel/v2.5/testing/cset/cset-bunk@stusta.de%5Bjgarzik%5D%7CChangeSet%7C20050223015628%7C49266.txt>

[PATCH] drivers/net/via-rhine.c: make a variable static const

This patch makes a needlessly global variable static const.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

----------------------------------

It's possible I simply don't get it, but the above description of a 
patch hardly seems like it would qualify for the intentions of the 
2.6.x.y series.

Is this typical, and is this in line with the intent of the x.y series?

If this is going to achieve the objective, the gatekeeper has to be a 
real stubborn, unpopular horse's ass it seems, with a sign on his 
forehead that reads:  GO AWAY AND COME ANOTHER DAY!

Somewhat disappointedly,

Dick

-- 
Please help fix the U.S. software industry before it is too late.
Contact your U.S. representatives with this information:
http://lpf.ai.mit.edu/Patents/industry-at-risk.html
http://www.groklaw.net/article.php?story=20041003041632172


