Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVBFRAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVBFRAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVBFRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:00:31 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:62669 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S261211AbVBFRAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:00:23 -0500
Subject: Re: Dell Inspiron sensors (was: Re: Huge unreliability - does
	Linux have something to do with it?)
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MPG.1c7035d63901d496989710@news.gmane.org>
References: <5a2cf1f605020401037aa610b9@mail.gmail.com>
	 <20050204121817.GA7721@animx.eu.org>
	 <d120d50005020406441ba6f919@mail.gmail.com>
	 <MPG.1c7035d63901d496989710@news.gmane.org>
Content-Type: text/plain
Message-Id: <1107709117.3828.6.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 06 Feb 2005 11:58:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 10:58, Giuseppe Bilotta wrote:
> I have a Dell Inspiron 8200, from March 2002. Since end of 
> December 2004 I've started having system lockups which at first 
> I couldn't identify, although they seemed to be overheating 
> related. So I started monitoring the temperatures on all the 
> components in my system (I can monitor CPU, GPU and HD temp; 
> more on this later), and noticed that the lockups happen when 
> the HD temp gets around 40 C. Indeed, they are 99% of the time 
> preceded by a loud "click" coming from the HD wereabouts ... 
> haven't lost any data yet but I've started backing up 
> everything and getting ready to get a replacement HD.


You might want to try this;

Remove the keyboard, remove the cover beneath.  Take a can of air dust
(or equivalent) and *carefully* blow out the inside of the laptop.  

-then-

Look at the back side and the right side of the laptop.  You'll see the
intake for air and the A/C unit.  Take that air dust and blow in such
that the plastic fan whirls away.   Take a snapshot of the dust bunnies
and send them to Dell.


I have a 5150 Inspiron.  In less than 1 year this thing started powering
off (hard) on its own, no matter the OS installed (multi-boot).  I dug
around the 'net and found similar issues, all relating to OVERHEATING. 
Poorly designed was the culprit, but Dell has not yet admitted to this
(but look at the Dell Linux forum or just Dell laptop forum and see
Dell's techs replies) - think of the numbers sold and it makes sense.

Anyways, aside from that, I had a dust bunny the size of a U.S. quarter
fly out.  Since then I make certain to rest it on a flat surface (I cut
some steel and carry it with me) and every couple of months take it
apart as described and blow out the dust.  

-fd


