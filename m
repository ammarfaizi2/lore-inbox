Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311725AbSCNSlR>; Thu, 14 Mar 2002 13:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311722AbSCNSlI>; Thu, 14 Mar 2002 13:41:08 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:1178 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S311720AbSCNSk7>;
	Thu, 14 Mar 2002 13:40:59 -0500
Message-ID: <3C90EEB9.5050007@candelatech.com>
Date: Thu, 14 Mar 2002 11:40:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva>	<3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com>	 <3C90E994.2030702@candelatech.com> <1016130404.4289.5.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:

> On Thu, 2002-03-14 at 13:19, Ben Greear wrote:
> 
> 
>>I did a clone with this.  However, I see no files, only
>>directories.  The files do seem to be in the SCCS directories,
>>but I don't know how to make them appear in their normal place.
>>
> 
> Uh that is how BK works.  The files are stored.  Try
> 
> 	bk -r co
> 
> to get all the files.  Omit the `-r' to check out only the current
> directory.


Ahh, that did fix the problem.  It must be configured differently
where I work, because I do not have to do the bk -r co command there.


> 
> There are some decent tutorials and such on bitmovers[1] page.
> 
> [1] http://www.bitmover.com


I went though them once...looks like I need a refresher course!

Thanks,
Ben


> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


