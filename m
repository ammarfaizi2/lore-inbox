Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTIDWvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIDWvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:51:54 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:43139 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262160AbTIDWvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:51:51 -0400
Date: Fri, 05 Sep 2003 09:44:10 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: swsusp: revert to 2.6.0-test3 state
In-reply-to: <Pine.LNX.4.33.0309041247380.940-100000@localhost.localdomain>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1062711850.12030.13.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.33.0309041247380.940-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. Since you've both given 'comforting' replies, I'll stop getting
worried, get on with finishing the 2.4 version of 1.1 and then get the
port up-to-date and going. But I'm still not sure what to prepare
patches against or who to send them to. Hopefully you'll have that
sorted by the time I'm ready to release 1.1 for 2.4.

Regards,

Nigel

On Fri, 2003-09-05 at 07:55, Patrick Mochel wrote:
> > I've said I want the patch reverted. I still want that, because you
> > changed way too quickly with too little testing. That does not mean
> > I'm not going to accept your patches in future. (In fact, my plan is
> > to  get -test3 version of swsusp back for -test5, then fix up driver
> > model/swsusp until we have -test3 functionality back, then start
> > taking your patches). 
> 
> That's fine. Do what you want at your own pace, with your own code. 
> 
> I don't think you understood my assertion of not working with you, though.  
> I'm not going to wait around for you to merge my patches, or take more
> abuse from you. I have better things to do, and a stringent time frame in
> which to do them.
> 
> I recommend either a) accepting my changes and fixes, and help merge
> Nigel's 2.4 changes into the base or b) accepting the fork, merging
> Nigel's changes, and later trying to merge the two source bases. 
> 
> 
> 	Pat
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

