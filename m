Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTBGQ3o>; Fri, 7 Feb 2003 11:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTBGQ3o>; Fri, 7 Feb 2003 11:29:44 -0500
Received: from [81.2.122.30] ([81.2.122.30]:54535 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266038AbTBGQ3n>;
	Fri, 7 Feb 2003 11:29:43 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302071639.h17Gd9EZ001493@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 morse code panics
To: ryan@michonline.com (Ryan Anderson)
Date: Fri, 7 Feb 2003 16:39:09 +0000 (GMT)
Cc: spacey-linux-kernel@lenin.nu, linux-kernel@vger.kernel.org
In-Reply-To: <20030207155144.GD13861@michonline.com> from "Ryan Anderson" at Feb 07, 2003 10:51:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Especially since a number of Linux developers have ham radio
> > > experience.
> > 
> > Well most linux users don't.  I'm sure its really easy to find a morse
> > code chart in many hundreds of places online.  But 2 scripts - one
> > that turns keyboard input or mic input into dots and dashes (so you
> > can enter it yourself or put the phone up to the system's microphone)
> > would help.  Then all you'd need is a morse->ascii converter.
> > 
> > So who's got a good morse->ascii program?  And who has the
> > dot-dash->.-.-.- translator?  And the audio->.-.-.- translator?

We already discussed the idea of a userspace program to decode the
morse:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104401177724846&w=2

> emacs (I'm not a user, though) has something like M-x-morse that will
> convert back and forth.

Yes, M-x morse-region.

John.
