Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUIKKlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUIKKlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUIKKlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:41:49 -0400
Received: from open.hands.com ([195.224.53.39]:56470 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268088AbUIKKlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:41:47 -0400
Date: Sat, 11 Sep 2004 11:52:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CMedia CM9739 - sneaked in via some cheap via motherboards
Message-ID: <20040911105251.GB19158@lkcl.net>
References: <20040910222155.GA19158@lkcl.net> <1094852761.18235.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094852761.18235.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 10:46:04PM +0100, Alan Cox wrote:
> On Gwe, 2004-09-10 at 23:21, Luke Kenneth Casson Leighton wrote:
> > it _almost_ works - it just doesn't recognise the PCM slider.
> > alsamixer can't set PCM
> > kmix and kamix don't even _show_ PCM.
> > 
> > which ain't much cop, really, cos no PCM means "no sound matey".
> 
> If I remember rightly the PCM on these is mute only. We fixed that for
> OSS it may be it didnt get propogated into ALSA or this is some new
> horrible variant. What we don't have is a fast software volume control
> in OSS, dunno if ALSA has one.

 oh dearie me, well this chip _is_ listed as an         ac97->id == 0x434d4961
 and no the sound ain't working.

 i'm going to pretend it does have PCM, see what happens...

 l.

