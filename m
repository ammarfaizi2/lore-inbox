Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTBUBfU>; Thu, 20 Feb 2003 20:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBUBfU>; Thu, 20 Feb 2003 20:35:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:10404 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266996AbTBUBfT>; Thu, 20 Feb 2003 20:35:19 -0500
Date: Thu, 20 Feb 2003 17:36:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stacy Woods <spwoods@us.ibm.com>
Subject: Re: Bugs sitting in RESOLVED state
Message-ID: <276780000.1045791394@flay>
In-Reply-To: <3E557F9F.9000803@pobox.com>
References: <273770000.1045789304@flay> <3E557F9F.9000803@pobox.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> These bugs have been sitting in RESOLVED state for > 1 week, ie
>> they have fixes, but aren't back in the mainline tree (when they
>> should move to CLOSED state). If the fixes are back in mainline
>> already, could the owner close them out? Otherwise, perhaps we
>> can get those fixes back in?
> 
> 
> Several of my bugs are sitting in the resolve state because of Bugzilla
> user interface issues.  The interface does not allow me to take a bug
> directly from "assigned" to "closed" state.  Closed is not even presented
> as an option.  If the bug is indeed in the resolved state, then I can
> close the bug.  But this two-step process is a bit silly.

OK, I'll ask Jon if we can fix that ...
 
> Also, several of my 'resolved' bugs have comments that clearly indicate
> the fix has been merged.  So, now I must go in a clicking spree, taking
> valuable time away from hacking :)  Don't we have kind and gracious
> Bugzilla janitors for this sort of thing?

heh ;-) will try to sort something out for that ... we ought to go through
each one and do a simple check like that, before we send out such lists.

M.

