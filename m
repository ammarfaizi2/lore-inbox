Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVL0Ppd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVL0Ppd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 10:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVL0Ppc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 10:45:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2476 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751117AbVL0Ppb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 10:45:31 -0500
Date: Tue, 27 Dec 2005 16:45:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jason Munro <jason@stdbev.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, rostedt@goodmis.org,
       jaco@kroon.co.za, linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume support (try 2)
Message-ID: <20051227154509.GB1822@elf.ucw.cz>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za> <1135607906.5774.23.camel@localhost.localdomain> <200512261535.09307.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0512262323110.12671@yvahk01.tjqt.qr> <c5fab017ea006f87e47b347f10a6a0ae@stdbev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5fab017ea006f87e47b347f10a6a0ae@stdbev.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 27-12-05 09:20:15, Jason Munro wrote:
> On 4:26:17 pm 26 Dec 2005 Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >>
> > >>  I use pine and evolution.  Pine is text based and great when I
> > >>  ssh into my machine to work.  Evolution is slow, but plays well
> > >>  with pine and it handles things needed for LKML very well. (the
> > >>  drop down menu "Normal" may be changed to "Preformat", which
> > >>  allows of inserting text files "as-is").
> > >
> > > Dare I say it, KMail has also been doing the Right Thing for a long
> > > time. It will only line wrap things that you insert by typing;
> > > pastes are left untouched.
> > >
> > > This satisfies Linus's demand that all patches be part of the email
> > > body and not an attachment.
> >
> >
> > Do not always blame the MUA, because actually, the MTAs may do
> > anything with the mail text. That's (among other reasons) why things
> > like MIME attachments were invented, because they (their respective
> > uuencoded or base64encoded "text") can be wrapped but does not change
> > the decoded form.  - Something like that is in the pine doc.
> 
> So which is preferable for someone handling inline patches. A properly
> encoded message text that when decoded with a compliant client accurately
> represents the original text (no whitespace mangling etc), or a message
> text that is accurate in it's raw state but may be altered during transit?

inlined text. I've never seen MTA mangling patch. Maybe 15 years ago...
									Pavel
-- 
Thanks, Sharp!
