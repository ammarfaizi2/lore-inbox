Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVL0Rxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVL0Rxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVL0Rxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:53:36 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:31546 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932355AbVL0Rxf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:53:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pyUxGFLinXfMMCdsDIkxhEE9+wYw+od3LwxyqFByWQU7eIQSeAucpkuTNerbkXoI1nJAMlNsyCyhYxxIUdl7uQPKpdrX2lJxf6a5SjRTrnjks5pAIAHhS+aPgYeEjIBL7xpaB4Kcfd8UEzkSaj6hbsPSOrQPOyXnDCzVnYN38oc=
Message-ID: <37219a840512270953w6c35d1f1o15553ab81b0b58f4@mail.gmail.com>
Date: Tue, 27 Dec 2005 12:53:34 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
Cc: Lee Revell <rlrevell@joe-job.com>, Mark Knecht <markknecht@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43B1405D.2050202@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
	 <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
	 <1135620892.8293.60.camel@mindpipe> <43B1405D.2050202@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/05, James Courtier-Dutton <James@superbug.co.uk> wrote:
> Lee Revell wrote:
> > On Mon, 2005-12-26 at 10:02 -0800, Mark Knecht wrote:
> >
> >>Hi Linus,
> >>   I've visiting at my parents house and gave 2.6.15-rc7 a try on my
> >>dad's machine. This machine is his normal desktop box which I
> >>administer remotely, as well as a MythTV server. The new kernel built
> >>and booted fine. I then built the NVidia stuff. However when I tried
> >>to build the ivtv driver from portage it failed:
> >
> >
> > There's nothing the kernel developers can do about regressions in out of
> > tree modules - there is no stable kernel module API so the authors of
> > that module will have to fix it.
> >
> > Any idea why the IVTV module has not been submitted for mainline?
> >
> > Lee
> >
>
> No idea. I even asked the IVTV developers mailing list some time ago
> trying to get them to include it in mainline, but they did not want to
> for some odd reason I could not work out.
>
> Maybe someone else can kick them a little harder. :-)

Hehe... Please see the earlier messages in this thread... It is a
plan-in-motion.  Maybe for 2.6.17 or 2.6.18.  ...depending on some
other factors...

-Mike
