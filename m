Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCKPPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCKPPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:15:51 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:12945 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261234AbUCKPPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:15:47 -0500
Message-ID: <405082A2.5040304@blueyonder.co.uk>
Date: Thu, 11 Mar 2004 15:15:46 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: NVIDIA and 2.6.4?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2004 15:15:46.0474 (UTC) FILETIME=[BA8310A0:01C4077B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 5336 with 2.6.4-rc2-mm1 and it locks the box up completely after 
switching to kdm. It worked with 2.6.3-mm4 previously, now even that 
kernel gets a lock up. I've done a reiserfsck --rebuild-tree which 
repaired some files and left 10 files in /lost+found and I can't 
determine what they are.
I am currently using 2.6.4-rc2-mm1 with the standard SuSE 9.0  Driver "nv".
I also went back to the minion.de release and still got a lockup, I 
guess it's down to some of those files in lost+found that are missing.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

