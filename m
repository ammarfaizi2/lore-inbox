Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUEIWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUEIWsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbUEIWsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:48:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9704 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264411AbUEIWsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:48:07 -0400
Date: Mon, 10 May 2004 00:48:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Rob Landley <rob@landley.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-ID: <20040509224806.GF15307@atrey.karlin.mff.cuni.cz>
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <20040503123150.GA1188@openzaurus.ucw.cz> <200405042018.23043.rob@landley.net> <20040508225401.GF29255@atrey.karlin.mff.cuni.cz> <1084141917.20486.8.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084141917.20486.8.camel@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Nigel's refrigerator is way more elaborate and very intrusive, but he
> > seems to work *always*. Original refrigerator (shared by swsusp and
> > pmdisk) only tries a bit and eventually gives up if stopping system is
> > too hard. Hopefully Nigel's code can be simplified.
> 
> It's actually pretty simple. I just need to explain it more clearly.

Well, anything that touches 10+ core kernel files is by definition
complex ;-).

> > He's out of time, so money is not likely to help. Sending some money
> > to Nigel might do the trick ;-).
> 
> Sending money to me won't help either, except with getting support for
> new hardware. I'm working on finding and blatting a little but
> significant bug that's made its way in since 2.0. Then I'm only going to
> be working on merging.
> 
> Rob, I would concentrate on figuring out what makes Pavel's version work
> for you and the other two not work. Perhaps then we can adjust our
> implementations to address the issue and make you a happy camper :>

Its actually Patrick's version that works for him... But my and
patrick's shoudl be pretty similar, so it should be rather easy to
compare.

Oh and if you will like Patrick's version more and will try to port
some cleanups from his version... Just try to send a patch.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
