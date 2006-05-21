Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWEUXGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWEUXGT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWEUXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:06:19 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:25247 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751542AbWEUXGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:06:18 -0400
Subject: Re: [v4l-dvb-maintainer] [PATCH 00/33] V4L/DVB bug fixes
From: hermann pitton <hermann-pitton@arcor.de>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4470A475.7040106@m1k.net>
References: <20060513094537.PS23916900000@infradead.org>
	 <446F6F46.9090605@m1k.net> <1148180387.4222.13.camel@pc08.localdom.local>
	 <4470A475.7040106@m1k.net>
Content-Type: text/plain
Date: Mon, 22 May 2006 01:10:56 +0200
Message-Id: <1148253056.4548.9.camel@pc08.localdom.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 21.05.2006, 13:33 -0400 schrieb Michael Krufky:
> hermann pitton wrote:
> 
> >Am Samstag, den 20.05.2006, 15:34 -0400 schrieb Michael Krufky:
> >  
> >
> >>mchehab@infradead.org wrote:
[...]

> >  
> >
> Hermann,
> 
> The bugfixes that I am concerned about do not include the refactoring 
> changes from Andrew -- those are not even bugfixes at all, and they are 
> only accessible through our mercurial tree.  We do not plan to send 
> those upstream until 2.6.18  -- This has nothing at all to do with 
> Mauro's latest git-pull-request, or my email to Linus.
> 
> >At least, and thanks again for calming me down once, it is not about
> >some white space only now.
> >
> I'm not sure what you mean.  Sure, we do have some drastic changes 
> coming up for 2.6.18 ...  but this email is about bugfixes that HAVE in 
> fact been thoroughly tested.
> 
> It sounds to me as if you may be getting the pending changesets in 
> Mauro's git tree confused with current changes in our mercurial 
> development repository.
> 
> Just take a look at v4l-dvb.git ...   (or at the diffstat earlier in 
> this thread) ..  You will find that the drastic changes that you have 
> mentioned aren't there yet.  Those do need some more testing before 
> being sent upstream... I think they'll be ready in time for the 2.6.18 
> merge window, but this is not the issue right now.
> 
> Thanks for your concern,

;)

Mike,

for some users it will really look like broken multimedia on 2.6.17 like
you said. I don't worry to send them to something else then, but it
would really be nice to get the obvious fixes in or a hint, why it is
too late or so.

The mixture of a for some broken 2.6.17 and a upcoming 2.6.18 with huge
changes and a maybe too small testing base could become funny.

But yes, as you said, it are only concerns for now.

Cheers,
Hermann


