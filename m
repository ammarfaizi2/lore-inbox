Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282061AbRKVHLT>; Thu, 22 Nov 2001 02:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282062AbRKVHLJ>; Thu, 22 Nov 2001 02:11:09 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:1036 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S282059AbRKVHLC>; Thu, 22 Nov 2001 02:11:02 -0500
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: Linux FSCP (Frequently Submitted Compilation Problems)?  (was:  Re: Loop.c File !!!!)
Date: Thu, 22 Nov 2001 08:07:42 +0100
Organization: Cistron Internet Services B.V.
Message-ID: <9ti8e5$9bl$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.21.0111202025290.6299-100000@brick> <5.1.0.14.2.20011121082413.00abadd0@pop.gmx.net> <5.1.0.14.0.20011122100929.009ead30@mail.amc.localnet>
X-Trace: ncc1701.cistron.net 1006413061 9589 213.46.44.164 (22 Nov 2001 07:11:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stuart Young" <sgy@amc.com.au> wrote in message
news:cistron.5.1.0.14.0.20011122100929.009ead30@mail.amc.localnet...
> At 10:10 AM 21/11/01 +0100, Rob Turk wrote:
> >Good suggestion. Unfortunately, many people obviously do not take the time
> >to read the newsgroup before they post, so what do you propose will be the
> >mechanism to encourage them to lookup existing issues?
>
> Why not do it like the current Changelog, put it in the kernel repository,
> and make sure it hits all the mirrors. A little selective advertising (eg:
> someone mention it on slashdot, newsforge, debianplanet, etc), and people
> will start using it. Just suffix the file with the version number, just
> like the Changelog. Because the file will be small, it's possible that some
> mirrors will get quick updates before they get the kernel itself. This
> covers all the version specific problems at least.
>
>
> Stuart Young - sgy@amc.com.au
> (aka Cefiar) - cefiar1@optushome.com.au
>

Most of the people which post without reading previous entries in the newsgroup
will also not read FRB (Frequently Reported Bugs) files. I actually got a great
suggestion in from Martin Bene. He suggests putting a last line in the build
process which always shows up if a failure occurs during kernel compiles.
Something along the lines of 'Your kernel failed to build. Check
www.where-ever-the-buglist-is.org for known issues with your kernel. Post your
problem on the kernel list if this is not a FRB'. Is this something that can be
done easily?

As a suggestion for such a web site, it would probably help if people who see
'their' bug present could file a description under the frb on such a web site,
to help developers figure out how many people are impacted and maybe to
correlate the circumstances.

Rob




