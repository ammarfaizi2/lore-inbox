Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267096AbUBSJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267099AbUBSJZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:25:09 -0500
Received: from gw-nl3.philips.com ([161.85.127.49]:61692 "EHLO
	gw-nl3.philips.com") by vger.kernel.org with ESMTP id S267096AbUBSJZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:25:04 -0500
Message-ID: <4034819E.7030004@basmevissen.nl>
Date: Thu, 19 Feb 2004 10:27:58 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Dittmer <j.dittmer@portrix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl> <20040206191840.GB2459@thunk.org> <40274AEF.8040600@basmevissen.nl> <4032D6E6.1060906@tmr.com>
In-Reply-To: <4032D6E6.1060906@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
>> It looks like this only appeared once. The FS looks fine now. So I guess
>>  I won't be able to reproduce it. Let's just go to 2.6.[23] and see if
>> it happens again.
> 
> Did this go away on reboot, or did you have to fix it? If it went away
> on reboot, it could be that the copy of the inode in memory was borked.
> 

I really had to fix it. But, it never appeared again until now. So maybe 
this was just caused by some crash while experimenting with swsusp2.

Regards,

Bas.


