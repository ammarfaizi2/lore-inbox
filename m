Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbTGTLFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 07:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbTGTLFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 07:05:07 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:52890 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S266897AbTGTLFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 07:05:02 -0400
Date: Sun, 20 Jul 2003 23:20:31 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: [Swsusp] 2.5 suspend.c changes ahead
In-reply-to: <20030720111041.GA305@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>, Jan Rychter <jan@rychter.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058700016.1705.4.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030708233507.GB140@elf.ucw.cz>
 <200307091940.52781.mflt1@micrologica.com.hk>
 <20030709181830.GA355@elf.ucw.cz> <m2u19rau8v.fsf@tnuctip.rychter.com>
 <20030720111041.GA305@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Longer term, I don't want them to be entirely different beasts. Once I
get swapfile support working for 2.4, I have no plans for further
development. I plan that my next task will be to port it to 2.5/6, and
then begin to seek to merge it with Pavel, Andrew or whoever will take
patces as far as they are willing.

Regards,

Nigel

On Sun, 2003-07-20 at 23:10, Pavel Machek wrote:
> Hi!
> 
> >  > I guess I'll do some big kernel/suspend.c changes tommorow. If you
> >  > have some changes pending, please submit them within next 10 hours (I
> >  > can't code while I sleep ;-).  Pavel
> >  >>
> >  >> Looking forward!
> > 
> >  Pavel> Okay, I should start doing something.
> > 
> >  >> Swsusp for 2.4 is nearing 1.0.
> > 
> > How is 2.5 swsusp going to be related to 2.4 swsusp? I am not sure I
> > understand the relationship -- it seems the two codebases have diverged
> > quite a bit?
> > 
> > Is it going to be an entirely different beast?
> 
> Entirely different beast.
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

