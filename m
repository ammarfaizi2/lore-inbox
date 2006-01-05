Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWAEMmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWAEMmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAEMmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:42:07 -0500
Received: from drugphish.ch ([69.55.226.176]:17048 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751310AbWAEMmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:42:06 -0500
Message-ID: <43BD146B.2010308@drugphish.ch>
Date: Thu, 05 Jan 2006 13:43:23 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch> <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>But http://ttyrpld.sourceforge.net/ looks indeed interesting, however no 2.4.x
>>support from what I can see.
>  
> Do you really need 2.4 support?

Well, 90% of our managed Linux servers run 2.4.x kernels. Granted, 
that's only a couple of hundred nodes scattered all over the world; but 
the question is more, if I really want to integrate ttypld into our 
kernel/distro.

> Well, after all, I can add it back, it's 
> not too much #defines and stuff.

I'll let you know if I need it; I reckon it might not be too difficult 
to backport it anyway, so I can also do it myself ;).

Thanks and best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
