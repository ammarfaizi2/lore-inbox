Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVLIQip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVLIQip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVLIQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:38:44 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:54806 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932461AbVLIQio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:38:44 -0500
Message-ID: <4395EB14.60802@tmr.com>
Date: Tue, 06 Dec 2005 14:48:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain> <4394C745.2020802@tmr.com> <4394EDDE.30605@pobox.com>
In-Reply-To: <4394EDDE.30605@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Bill Davidsen wrote:
> 
>> I do think the old model was better; by holding down major changes for 
>> six months or so after a new even release came out, people had a 
>> chance to polich the stable release, and developers had time to 
>> recharge their batteries so to speak, and to sit and think about what 
>> they wanted to do, without feeling the pressure to write code and 
>> submit it right away. Knowing that there's no place to send code for 
>> six months is a great aid to generating GOOD code.
> 
> 
> It never worked that way, which is why the model changed.
> 
> Like it or not, developers would only focus on one release.  In the old 
> model, unstable things would get shoved into the stable kernel, because 
> people didn't want to wait six months.  And for the unstable kernel, it 
> would often be so horribly broken that even developers couldn't use it 
> for development (think 2.5.x IDE).

I was actually thinking of Rusty's module code... I do every time I have 
to build an initrd file by hand "Although the syntax is similar to the 
older /etc/modules.conf, there are many features missing."

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

