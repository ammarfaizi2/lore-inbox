Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSKNWCz>; Thu, 14 Nov 2002 17:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSKNWCz>; Thu, 14 Nov 2002 17:02:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61064 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261605AbSKNWCx>;
	Thu, 14 Nov 2002 17:02:53 -0500
Date: Thu, 14 Nov 2002 15:04:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <266800000.1037315048@flay>
In-Reply-To: <3DD407CA.3010809@pobox.com>
References: <225710000.1037241209@flay> <mailman.1037294313.19087.linux-kernel2news@redhat.com> <200211141912.gAEJCwH01539@devserv.devel.redhat.com> <261220000.1037307324@flay> <3DD407CA.3010809@pobox.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, that's what he meant (further clarified locally on IRC)... zaitcev->sparc32 bugs, and davem->sparc64 bugs.

OK, I'll get that fixed up. 
 
>> > admin load, because Bugzilla is not going to be self-running.
>> > Who is that person?
>> 
>> I'm hoping to spread the admin load out amongst different people -
>> one of the things for a system like this is that it's easier to scale
>> it up by spreading the load. Anything that's not picked up by external
>> people will have the slack picked up by some IBM people, to make sure
>> the database doesn't end up as a fetid cesspit of festering stale
>> misinformation ;-)
> 
> I just re-assigned a bug, which generated a request in my mind:  is 
> there a default bug assignee besides you?  :)

The default assignee depends on the category you file into. 
I own a lot of them right now because there's nobody else to do it
(though I have various volounteers now, so thats increasingly less
true ...yay!).

M.

