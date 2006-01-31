Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWAaXyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWAaXyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWAaXyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:54:47 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:62667 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751094AbWAaXyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:54:46 -0500
Message-ID: <43DFF906.1090805@tmr.com>
Date: Tue, 31 Jan 2006 18:55:50 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, bzolnier@gmail.com,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner>
In-Reply-To: <43DD2A8A.nailGVQ115GOP@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> 
>>>That's what I believe to be cdrecord/libscg bugs:
>>>
>>>1) libscg or cdrecord does not automatically probe all available
>>>  transports, but only SCSI:
>>
>>This one is IMO just "a missing feature", as I can get the ATA/PI list using
>>  cdrecord -dev=ATA: -scanbus
> 
> 
> It cannot be fixed unless the two first bugs from my Linux kernel
> bug report have been fixed.

Since we are making an effort to be civil, perhaps you might call these 
"characteristics" instead of bugs. Generally "bug" refers to an 
unintended behaviour, rather than an intended behaviour which may not be 
optimal.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
