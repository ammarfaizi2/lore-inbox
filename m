Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTBUBOO>; Thu, 20 Feb 2003 20:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBUBOO>; Thu, 20 Feb 2003 20:14:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32776 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261615AbTBUBON>;
	Thu, 20 Feb 2003 20:14:13 -0500
Message-ID: <3E557F9F.9000803@pobox.com>
Date: Thu, 20 Feb 2003 20:23:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Stacy Woods <spwoods@us.ibm.com>
Subject: Re: Bugs sitting in RESOLVED state
References: <273770000.1045789304@flay>
In-Reply-To: <273770000.1045789304@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> These bugs have been sitting in RESOLVED state for > 1 week, ie
> they have fixes, but aren't back in the mainline tree (when they
> should move to CLOSED state). If the fixes are back in mainline
> already, could the owner close them out? Otherwise, perhaps we
> can get those fixes back in?


Several of my bugs are sitting in the resolve state because of Bugzilla 
user interface issues.  The interface does not allow me to take a bug 
directly from "assigned" to "closed" state.  Closed is not even 
presented as an option.  If the bug is indeed in the resolved state, 
then I can close the bug.  But this two-step process is a bit silly.

Also, several of my 'resolved' bugs have comments that clearly indicate 
the fix has been merged.  So, now I must go in a clicking spree, taking 
valuable time away from hacking :)  Don't we have kind and gracious 
Bugzilla janitors for this sort of thing?

	Jeff



