Return-Path: <linux-kernel-owner+w=401wt.eu-S1752686AbWLRSF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbWLRSF2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbWLRSF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:05:28 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:45403 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752652AbWLRSF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:05:27 -0500
Message-ID: <4586D861.9040708@lwfinger.net>
Date: Mon, 18 Dec 2006 12:05:21 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: towsonu2003@gmail.com
CC: Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: bcm43xx: iwlist scan: "no scan results" with 2.6.19.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read your message on LKML and the bugzilla entry. For best results with bcm43xx problems, please 
post to the bcm43xx mailing list or to the netdev mailing list (both are on the CC list here).

Unfortunately, you built your 2.6.19.1 system with bcm43xx debugging disabled. It is impossible to 
say what happened, but usually when booting to Windows fixes a problem, the fault lies in the 
firmware, but the lack of debugging info doesn't even let us know what firmware was loaded.

With the info you provide and your inability to test patches, there isn't much we can do.

Larry
