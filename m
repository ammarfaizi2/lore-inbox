Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUGHVnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUGHVnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUGHVnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:43:02 -0400
Received: from sls-dd2p15.dca2.superb.net ([66.235.184.60]:43998 "EHLO
	sls-ce5p212.hostitnow.com") by vger.kernel.org with ESMTP
	id S264373AbUGHVm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:42:58 -0400
Message-ID: <40EDB764.6060107@securesystem.info>
Date: Fri, 09 Jul 2004 06:06:44 +0900
From: Chris White <webmaster@securesystem.info>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040417)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel fchown() exploit status?
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p212.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - securesystem.info
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a recent security announcment regarding a vulnerability with 
the fchown function.

Only a few distrobutions (red hat/suse) have fixed the issue, but I've 
yet to see a general patch for it.

Information regarding the issue is here:

http://xforce.iss.net/xforce/xfdb/16599

I searched around the archive databases, but did not come up with it 
(unless I skipped over something accidentaly)

Thank you for your time and appologies if this is a duplicate.

-----------------
Chris White
