Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTCYSZN>; Tue, 25 Mar 2003 13:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263230AbTCYSZN>; Tue, 25 Mar 2003 13:25:13 -0500
Received: from lakemtao01.cox.net ([68.1.17.244]:37791 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP
	id <S263228AbTCYSZK>; Tue, 25 Mar 2003 13:25:10 -0500
Message-ID: <3E80A208.5050009@cox.net>
Date: Tue, 25 Mar 2003 12:38:00 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 hanging after exiting KDE
References: <3E809256.4040608@cox.net> <130800000.1048614548@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>After loading up with 2.5.66 my system started to have odd behavior upon
>>exiting KDE. It spontaneously rebooted once, but hangs the rest of the
>>time. Not even SysRq works. I updated to the bk this morning, but the
>>problem is still present. Not sure even where to start looking. Any ideas
>>on where I should start to look?
> 
> 
> Does this imply that 2.5.65 worked? Or you've upgraded from 2.4? I think
> nmi_watchdog (or maybe kgdb) is the standard course in such cases ...

Yes. 2.5.65-bk5 was the last one that appeared to work.
I don't have watchdog or kgdb on my system, and I have not used them 
before. Perhaps a download location for them and documentation would 
help. :-)

-David

