Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUCBX4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUCBX4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:56:36 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:30393 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261803AbUCBX42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:56:28 -0500
Date: Tue, 2 Mar 2004 15:56:26 -0800
From: Andy Isaacson <adi@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: bkbits hosting (was Re: [PATCH 0/9] New set of input patches)
Message-ID: <20040302235626.GD12565@bitmover.com>
References: <200402290153.08798.dtor_core@ameritech.net> <20040302130212.GA1963@ucw.cz> <200403021245.10915.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403021245.10915.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 12:45:10PM -0500, Dmitry Torokhov wrote:
> On Tuesday 02 March 2004 08:02 am, Vojtech Pavlik wrote:
> > I like them very much. Do you have a bitkeeper tree anywhere where I
> > could pull from, so that I don't have to apply these by hand?
>  
> No, unfortunately I don't have an accessible tree... Hmm, what does it take
> to get an account at kernel.bkbits.net?

I already sent private mail to Dmitry, but it occurs to me that other
developers are probably in the same straits.

The easiest thing to do in this case is to host your patches at
bkbits.net (hostme.bkbits.net, which is different than kernel.bkbits.net
-- kernel is a special case).  You don't have to change your workflow at
all, after it's been set up; you end up just pushing to the bkbits
repository when you've got changes to submit.

To set up a hosted project, just follow the directions under
http://www.bitkeeper.com/Hosted.html (the table of contents is on the
left).  You can clone Linus' tree to populate your tree initially, then
push your csets from your workstation to hostme.

If any kernel developers have difficulty doing this, drop me a line --
I'm trying to make the process easy and error-free, and I appreciate any
suggestions.

If any kernel developers are having BK workflow problems ("how do I
merge my work with other developers'?  How do I keep up-to-date without
generating hundreds of merge csets?") the first thing to do is to read
the BK kernel howto, http://lwn.net/2002/0425/a/bk-thing.php3.  If your
questions aren't answered there, send them to me or to the
bitkeeper-users list.

-andy
