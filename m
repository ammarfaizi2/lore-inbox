Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbREUDI6>; Sun, 20 May 2001 23:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbREUDIs>; Sun, 20 May 2001 23:08:48 -0400
Received: from www.microgate.com ([216.30.46.105]:51211 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262364AbREUDIc>; Sun, 20 May 2001 23:08:32 -0400
Message-ID: <002801c0e1a3$5dfb8f20$0201a8c0@mojo>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0105202032260.10653-100000@weyl.math.psu.edu>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Date: Sun, 20 May 2001 22:08:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alexander Viro" <viro@math.psu.edu>
> On Sun, 20 May 2001, Paul Fulghum wrote:
> > I'll be the first to admit there is some ugliness in my driver.
>
> So will anyone here regarding his or her code. Count me in, BTW.
>
> Could you reread the posting you are refering to?

Sorry if I misunderstood. My post was as much in
response to several current threads revolving around
device major numbers and ioctl calls (I use both!).

Many postings seem to imply driver writers must be flawed for
using these flawed facilities. Driver writers don't use device
major numbers and ioctl calls because they are brain damaged, they use
them because they are accepted practice and they work (albeit imperfectly).

I have no problem moving to better solutions *as they become available*.

But I have seen multiple references to 'causing pain' for people
by restricting their use while alternatives  (only now being discussed
and decided) are years away in the next stable kernel.

All I hope for  is a reasonable path to get there (better alternatives) from
here.
My 2 cents, with no intent to offend anyone.

Paul Fulghum paulkf@microgate.com
Microgate Corporation http://www.microgate.com





