Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVCCMvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVCCMvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCCMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:51:46 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:65511 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261558AbVCCMvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:51:40 -0500
Message-ID: <4227085C.7060104@drzeus.cx>
Date: Thu, 03 Mar 2005 13:51:40 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
Subject: intel 8x0 went silent in 2.6.11
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded to Linux 2.6.11 and the soundcard on my machine went 
silent. All volume controls are correct and there are no errors 
reported. But no sound coming from the speakers. And here's the kicker, 
the headphones work fine!
2.6.10 still works so the bug appeared in one of the patches in between.
The sound card is the one integrated into intels mobile ICH4 chipset.

Rgds
Pierre
