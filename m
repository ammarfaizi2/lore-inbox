Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTINLYB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTINLXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:23:16 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:14036 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262386AbTINLW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:22:26 -0400
Message-ID: <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: <linux-kernel@vger.kernel.org>, "Vojtech Pavlik" <vojtech@suse.cz>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Date: Sun, 14 Sep 2003 20:21:30 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andries Brouwer" <aebr@win.tue.nl> wrote:
> On Sun, Sep 14, 2003 at 12:51:32PM +0900, Norman Diamond wrote:
> > In thread "Re: Trying to run 2.6.0-test3", Alan Cox replied to me:
> >
> > > > What will it take this time?
> > >
> > > Posting the patch with any luck ?
> >
> > I knew that that would not be sufficient.
>
> Just repeat. Do not repeat the complaining because complaining
> with zero information content is just discarded.
> But if you repeat the patch, together with an explanation of why
> this is the correct patch, sooner or later somebody will look at it.

Due to the complexity of this answer, I am making three separate postings.

I make no assertion that the following is correct or is a patch, but think
that it deserves consideration.  I spend about one day each weekend testing
this kernel, have had patches ignored enough times, and seriously think of
rejoining the set of users who never have time to test.

----- Original Message ----- 
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Greg KH" <greg@kroah.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>; "Andries Brouwer" <aebr@win.tue.nl>;
"Vojtech Pavlik" <vojtech@suse.cz>
Sent: Monday, August 18, 2003 7:35 PM
Subject: Re: Trying to run 2.6.0-test3


> "Alan Cox" <alan@lxorguk.ukuu.org.uk> replied to me.
>
> > > accept a USB keyboard but they refused.  The patch which I sent to Vojtech
> > > Pavlik was ignored and these two keys continued not to work (except on my
> > > machine).  Finally Mike Fabian accepted a gift of a USB keyboard and this
> > > defect in Linux got fixed.  But only for somewhere around the last half of
> > > the 2.4 releases, not for 2.6.
> > > What will it take this time?
> >
> > Posting the patch with any luck ?
>
> Hirofumi Ogawa posted a patch for the yen-sign pipe key on 2003.07.23 for
> test1 but his patch still didn't get into test3.  On a PS/2 keyboard that
> seems to be the only key with any problem.
>
> Yesterday when I finally tried a USB keyboard and found that the backslash
> underbar has the same problem, maybe I was the first person to even try a
> Japanese USB keyboard in 2.6, and maybe no one at all tried some number of
> 2.5 series kernels.  As mentioned, usually I can only spend one day a week
> testing 2.6.  I'll try to spend one day next weekend trying to figure out
> the new necessary patch.  If I succeed, but if it gets ignored again, I'll
> probably rejoin the set of users who never have time to test.
>
> I really do think that if Andries Brouwer or Vojtech Pavlik would accept a
> gift of a USB keyboard then this kind of bug would be avoided a lot earlier.
>
