Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTF0WCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTF0WCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:02:37 -0400
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:16065 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id S264862AbTF0WBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:01:18 -0400
Message-ID: <3EFCC1EB.2070904@candelatech.com>
Date: Fri, 27 Jun 2003 15:15:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: davidel@xmailserver.org, mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
References: <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com>	<20030627.143738.41641928.davem@redhat.com>	<3EFCBD12.3070101@candelatech.com> <20030627.145456.115915594.davem@redhat.com>
In-Reply-To: <20030627.145456.115915594.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Fri, 27 Jun 2003 14:54:26 -0700
>    
>    I think you are putting too much work on the bug reporter(s).
> 
> Don't even talk to me about too much work.
> 
> Someone wants me to spend hours groveling through some pieces of code
> to track down some tricky bug, for free, and all I ask is that they
> retransmit the bug every once in a while if they don't see any
> response?

I don't care if you completely ignore the bugzilla, just let the
rest of us lesser mortals use it.  There's always the chance we
will find something we can fix and actually lessen your load.

> If they're not willing to do this, they DON'T care about the bug.
> Just like if people aren't willing to retransmit patches they want
> installed, they DON'T care about the patch.  And just like I don't
> want to apply patches people don't care about, I don't want any of my
> contributors looking at bugs that the bug reporter doesn't care about.

Forcing people to continue to retransmit the same report just pisses
people off, and in the end will get you less useful reports than if
you had flagged the report as 'please-gimme-more-info'.  And, most people,
especially the savvy ones, will find some sort of work-around and keep going.
That didn't fix the problem, it just made it invisible again untill the
next person hits it.

> Ben, you absolutely don't understand how all of this development works
> and what it relies upon to function properly.

Perhaps, but it's also possible that you are being a stubborn SOB
because you fear change :)

Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


