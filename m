Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWAEKGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWAEKGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWAEKGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:06:51 -0500
Received: from drugphish.ch ([69.55.226.176]:41667 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1750838AbWAEKGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:06:50 -0500
Message-ID: <43BCF005.1050501@drugphish.ch>
Date: Thu, 05 Jan 2006 11:08:05 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       linux-kernel@vger.kernel.org
Subject: [OT] Re: keyboard driver of 2.6 kernel
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Let's pretend it's some sort of auditing ;-)
> 
> Actually, I use my keylogger (advertised above) more for "situation 
> reconstruction" rather than spying. When you happen to have a multi-root
> environment and people "forget what they did", stuff like ttyrpld can 
> really be a gift compared to .bash_history (if it exists, after all).

If one needs it a bit less intrusive, she can also patch bash. A 
possible solution can be found here:

http://www.drugphish.ch/patches/ratz/bash/bash-3.0-fix_1439-3.diff

But http://ttyrpld.sourceforge.net/ looks indeed interesting, however no 
2.4.x support from what I can see.

Regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
