Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263377AbUCNPwj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 10:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbUCNPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 10:52:38 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:24441 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263377AbUCNPw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 10:52:27 -0500
Message-ID: <40547FA9.2080601@blueyonder.co.uk>
Date: Sun, 14 Mar 2004 15:52:09 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: bcm5700  driver at 100Mbit? tg3 doesn't do 100Mbit - 2.6.4-mm1
References: <4053F511.1070607@blueyonder.co.uk> <Pine.LNX.4.58.0403140322430.9920@puma.cabm.rutgers.edu>
In-Reply-To: <Pine.LNX.4.58.0403140322430.9920@puma.cabm.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2004 15:52:10.0578 (UTC) FILETIME=[4F942320:01C409DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananda Bhattacharya wrote:

>Yeah I had that problem so I just used the tg3 driver. The 
>bcm5700 is actually made by broadcom, while the tg3 is 
>somethting that tyan did for onboard ethernet chips, while 
>the bcm5700 is for PCI cards.
>
>So the bcm5700 should do the trick all in all :) 
>
>  
>
Thanks, I altered /etc/modprobe.conf, replacing bcm5700 with tg3, 
rebooted and it's OK.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

