Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTLGCeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 21:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbTLGCeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 21:34:25 -0500
Received: from web11506.mail.yahoo.com ([216.136.172.38]:10861 "HELO
	web11506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265287AbTLGCeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 21:34:23 -0500
Message-ID: <20031207023422.86164.qmail@web11506.mail.yahoo.com>
Date: Sat, 6 Dec 2003 18:34:22 -0800 (PST)
From: gary ng <garyng2000@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well said, which was my response to Linus yesterday
but you said it 100x better. Interfacing linux(which
is what a driver essentially does, may be file system
too) shouldn't be by default considered a derived
work. Using kernel header is a bit more iffy, as that
may accidentally 'copy' some linux code. A driver
writer must be careful in these situations. But the
burden of proof should still be on the linux
community, not the other way round.

regards

gary

On Sat, Dec 06, 2003 at 04:19:00PM -0500, Theodore
Ts'o wrote:
> But that aside, does the Open Source community
really want to push for
> the legal principal that just because you write an
independent program
> which uses a particular API, the license infects
across the interface?
> That's essentially interface copyrights, and if say
the FSF were to
> file an amicus curiae brief support that particular
legal principle in
> an kernel modules case, it's worthwhile to think
about how Microsoft
> and Apple could use that case law to f*ck us over
very badly.  
> 
> It would mean that we would not be able to use
Microsoft DLL's in
> programs like xine.  It would mean that programs
like Crossover office
> wouldn't work.  It would mean that Apple could
legally prohibit people
> from writing enhancements to MacOS (for example, how
do all of the
> various extensions in Mac OS 9 work?  They link into
the operating
> system and modify its behaviour.  If they are
therefore a derived work
> of MacOS, then Apple could screw over all of the
people who write
> system extensions of MacOS.)  
> 
> Be careful of what you wish for, before you get it. 
The ramifications
> of the statement that just because a device driver
is written for
> Linux, that it is presumptively a derived work of
Linux unless proven
> otherwise, is amazingly scary.  Fortunately, we can
hope that the law
> professor I talked to was right, and that such a
claim would be
> laughed out of court.  But if it isn't, look to
Microsoft and other
> unsavory companies to use that kind of case law to
completely screw us
> to the wall.....


__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
