Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVDEIvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVDEIvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDEIvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:51:09 -0400
Received: from mail.freepaq.dk ([213.150.59.107]:27411 "EHLO mail.freepaq.dk")
	by vger.kernel.org with ESMTP id S261615AbVDEItS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:49:18 -0400
Message-ID: <42525107.6060807@egholm-nielsen.dk>
Date: Tue, 05 Apr 2005 10:49:11 +0200
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Overcommit_memory logic fails when swap is off
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

After 2½ year I stumbled over this thread:

> On Wed, 2002-08-21 at 13:23, Alan Cox wrote:
>> 2.5 propses including the ability to set the %age between the 0% of
>> mode 3, the 50 of mode 2 and upwards to things relevant in some
>> embedded system cases. So for 2.6 you will be able to tune it in
>> different ways according to precise understanding of workload.
> Alan, hch or someone asked if it would be possible to merge the 2.5 
> behavior into 2.4-ac ... are you interested or do you not want to 
> break compatibility?

> Note for "mode 2" the behavior is identical. For "mode 3" they would 
> also need to set vm_memory_ratio to "0".

> If you are willing, I'll send you a diff...
 > Robert Love
As I can see, the patch never made it in 2.4.x, right?!
So, I would like a diff - if still possible :-)

I know it's been a while, but I'm stuck with a 2.4 kernel for my 
embedded device and have problems with the OOM...

Best regards,
  Martin Egholm

