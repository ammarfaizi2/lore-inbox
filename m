Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSDSLT5>; Fri, 19 Apr 2002 07:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312420AbSDSLT4>; Fri, 19 Apr 2002 07:19:56 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:40674 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S312418AbSDSLT4>; Fri, 19 Apr 2002 07:19:56 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Date: Fri, 19 Apr 2002 13:19:46 +0200
X-Mailer: KMail [version 1.4]
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.44.0204190340450.20646-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204191319.46292.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 09:43, Ingo Molnar wrote:
> On Fri, 19 Apr 2002, Dieter [iso-8859-15] Nützel wrote:
> > No uptodate O(1) patch for 2.4. Very sad. So there isn't any change to
> > see a current preemption patch on top of vm33 and O(1).
> >
> > [...]
> > I'm under the impression that "all" development is focused on 2.5.x, now.
>
> well, 2.5's scheduler bits were pretty much in flux in the past two months
> or so, partly due to the preemption feature going in. And there are a
> number of other changes in the pipeline as well. So what makes sense for
> 2.4 is Robert's plan: to backport O(1)+preempt once 2.5 is slowing down,
> that way we get the proper testing of both components, instead of a
> separated scheduler patch that doesnt even exist in that form in 2.5.

Thank you very much for your answer Ingo.
It was somewhat still around you. So I was not sure if we have to be worry 
about you.

OK, you are fine.

Regards,
	Dieter
